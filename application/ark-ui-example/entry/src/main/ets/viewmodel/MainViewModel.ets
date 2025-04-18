import ItemData from '../model/ItemData'

export class MainViewModel {
  /**
   * Get swiper image data.
   *
   * @return {Array<Resource>} swiperImages.
   */
  getSwiperImages(): Array<Resource> {
    let swiperImages: Resource[] = [
      $r('app.media.fig1'),
      $r('app.media.fig2'),
      $r('app.media.fig3'),
      $r('app.media.fig4')
    ];
    return swiperImages;
  }

  /**
   * Get data of the first grid.
   *
   * @return {Array<PageResource>} firstGridData.
   */
  getFirstGridData(): Array<ItemData> {
    let firstGridData: ItemData[] = [
      new ItemData(0, $r('app.string.my_love'), $r('app.media.love')),
      new ItemData(1, $r('app.string.history_record'), $r('app.media.record')),
      new ItemData(2, $r('app.string.message'), $r('app.media.message')),
      new ItemData(3, $r('app.string.shopping_cart'), $r('app.media.shopping')),
      new ItemData(4, $r('app.string.my_goal'), $r('app.media.target')),
      new ItemData(5, $r('app.string.group'), $r('app.media.circle')),
      new ItemData(6, $r('app.string.favorites'), $r('app.media.favorite')),
      new ItemData(7, $r('app.string.recycle_bin'), $r('app.media.recycle'))
    ];
    return firstGridData;
  }

  /**
   * Get data of the setting list.
   *
   * @return {Array<PageResource>} settingListData.
   */
  getSettingListData(): Array<Array<ItemData>> {
    let settingListData: ItemData[][] = [
      [
        new ItemData(0, $r('app.string.setting_list_news'), $r('app.media.news'), $r("app.string.setting_toggle"))
      ],
      [
        new ItemData(1, $r('app.string.setting_list_font'), $r('app.media.data')),
        new ItemData(2, $r('app.string.setting_list_menu'), $r('app.media.menu')),
      ],
      [
        new ItemData(3, $r('app.string.clear_cache'), $r('app.media.storage')),
        new ItemData(4, $r('app.string.setting_list_privacy'), $r('app.media.person_shield')),
      ],
      [
        new ItemData(5, $r('app.string.setting_list_about'), $r('app.media.about'))
      ]
    ];
    return settingListData;
  }
}

export default new MainViewModel()