export default class HttpGridItem {
  /**
   * Text of list item.
   */
  title: string;
  /**
   * Image of list item.
   */
  img: string;
  /**
   * Other resource of list item.
   */
  content: string;

  constructor(title: string, img: string, content: string) {
    this.title = title;
    this.img = img;
    this.content = content;
  }
}