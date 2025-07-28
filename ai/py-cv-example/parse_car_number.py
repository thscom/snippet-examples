import cv2
import os
from matplotlib import pyplot as plt


def plt_show_(img):
    """cv2转plt显示"""
    b, g, r = cv2.split(img)
    img = cv2.merge([r, g, b])
    plt.imshow(img)
    plt.show()


def plt_show(img):
    """灰度图片显示"""
    plt.imshow(img, cmap='gray')
    plt.show()


def gray_guass(img):
    """高斯模糊去噪"""
    img = cv2.GaussianBlur(img, (3, 3), 0)
    gray_img = cv2.cvtColor(img, cv2.COLOR_RGB2GRAY)
    return gray_img


def main():
    target_image = os.path.join(os.path.dirname(__file__), "res", "car01.jpeg")
    print(f"Target Image: {target_image}")
    # 读取图片
    origin_image = cv2.imread(target_image)

    # 灰度图像
    image = origin_image.copy()
    gray_image = gray_guass(image)

    # 边缘检测
    sobel_x = cv2.Sobel(gray_image, cv2.CV_16S, 1, 0)
    abs_x = cv2.convertScaleAbs(sobel_x)
    image = abs_x

    # 阈值化
    ret, image = cv2.threshold(image, 0, 255, cv2.THRESH_OTSU)
    # plt_show(image)

    # 区域选择
    kernel_x = cv2.getStructuringElement(cv2.MORPH_RECT, (30, 10))
    # 形态学操作: 闭运算（先膨胀后腐蚀）
    image = cv2.morphologyEx(image, cv2.MORPH_CLOSE, kernel_x, iterations=1)
    # plt_show(image)

    # 形态学操作: 腐蚀(erode) 膨胀(dilate)
    kernel_x = cv2.getStructuringElement(cv2.MORPH_RECT, (50, 1))
    kernel_y = cv2.getStructuringElement(cv2.MORPH_RECT, (1, 20))
    # x方向闭操作(抑制暗细节)
    image = cv2.dilate(image, kernel_x)
    image = cv2.erode(image, kernel_x)
    # y方向开操作(抑制暗细节)
    image = cv2.erode(image, kernel_y)
    image = cv2.dilate(image, kernel_y)
    # 中值滤波(去噪)
    image = cv2.medianBlur(image, 21)
    # plt_show(image)

    # 轮廓检测
    contours, hierarchy = cv2.findContours(
        image, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    for item in contours:
        rect = cv2.boundingRect(item)
        x, y, w, h = rect
        if (w > h * 3) and (w < h * 4.5):
            image = origin_image[y:y + h, x:x + w]
            # plt_show_(image)

    # 高斯去噪
    gray_image = gray_guass(image)
    # 阈值化
    ret, image = cv2.threshold(gray_image, 0, 255, cv2.THRESH_OTSU)
    # plt_show(gray_image)
    # 形态学操作
    kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (4, 4))
    image = cv2.dilate(image, kernel)
    # plt_show(image)

    # 轮廓检测
    contours, hierarchy = cv2.findContours(
        image, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)

    words = []
    word_images = []

    for item in contours:
        word = []
        rect = cv2.boundingRect(item)
        x, y, w, h = rect
        word.append(x)
        word.append(y)
        word.append(w)
        word.append(h)
        words.append(word)

    words = sorted(words, key=lambda x: x[0], reverse=False)
    i = 0
    for word in words:
        if (word[3] > word[2]*1.5) and (word[3] < word[2]*5.5) \
                and (word[2] > 10):
            i += 1
            if word[2] < 15:
                splite_image = image[
                    word[1]:word[1] + word[3],
                    word[0]-word[2]:word[0]+word[2]*2
                ]
            else:
                splite_image = image[
                    word[1]:word[1] + word[3],
                    word[0]:word[0]+word[2]
                ]
            word_images.append(splite_image)
    # print(words)

    for i, j in enumerate(word_images):
        plt.subplot(1, 7, i+1)
        plt.imshow(word_images[i], cmap='gray')
    plt.show()

    # template = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B',
    #             'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'L', 'M', 'N', 'P',
    #             'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
    #             '京', '沪', '津', '渝', '冀', '晋', '蒙', '辽', '吉', '黑', '苏',
    #             '浙', '皖', '闽', '赣', '鲁', '豫', '鄂', '湘', '粤', '桂', '琼',
    #             '川', '贵', '云', '藏', '陕', '甘', '青', '宁', '新', '警', '学']


if __name__ == "__main__":
    main()
