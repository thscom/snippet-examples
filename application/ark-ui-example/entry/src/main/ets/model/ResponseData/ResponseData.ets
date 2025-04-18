
import Value from './Value';

export default class ResponseData {
  public code: string;
  public value: Value;

  constructor(code: string, value: Value) {
    this.code = code;
    this.value = value;
  }
}