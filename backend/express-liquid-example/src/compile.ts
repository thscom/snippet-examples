import { Context, Liquid, TagToken, TopLevelToken, Value } from "liquidjs";
import { existsSync, mkdirSync, rmSync, writeFileSync } from "fs-extra";
import path from "path";

const engine = new Liquid({
  root: __dirname + "/tpl",
  extname: ".liquid",
});

const outputDir = path.join(path.dirname(__dirname), "dist");
console.log(outputDir);
if (existsSync(outputDir)) {
  rmSync(outputDir, { recursive: true });
}
mkdirSync(outputDir, { recursive: true });

engine
  .renderFile("hello", {
    title: "Hello World",
    message: "Hello World",
  })
  .then((html) => {
    writeFileSync(path.join(outputDir, "hello.html"), html, {
      encoding: "utf-8",
    });
  });

engine.renderFile("escaping", {}).then((html) => {
  writeFileSync(path.join(outputDir, "escaping.html"), html, {
    encoding: "utf-8",
  });
});

engine.registerTag("upper", {
  parse: function (tagToken: TagToken, remainTokens: TopLevelToken[]) {
    this.value = new Value(tagToken.args, engine);
  },
  render: function* (ctx: Context) {
    const str: string = yield this.value.value(ctx);
    return str.toUpperCase();
  },
});
engine.registerTag("rand", {
  parse: function (tagToken: TagToken) {
    this.items = tagToken.args.split(" ");
  },
  render: function* (ctx: Context, emitter) {
    const index = Math.floor(Math.random() * this.items.length);
    emitter.write(this.items[index]);
  },
});
engine.registerTag("wrap", {
  parse: function (tagToken: TagToken, remainTokens: TopLevelToken[]) {
    this.tpls = [];
    let closed = false;
    while (remainTokens.length > 0) {
      const token: TopLevelToken | undefined = remainTokens.shift();
      if (token && (token as TagToken).name === "endwrap") {
        closed = true;
        break;
      }
      let tpl = this.liquid.parser.parseToken(token as TagToken, remainTokens);
      this.tpls.push(tpl);
    }
    if (!closed) {
      throw new Error(`tag ${tagToken.getText()} not closed`);
    }
  },
  render: function* (ctx: Context, emitter) {
    emitter.write('<div class="wrapper">');
    yield this.liquid.renderer.renderTemplates(this.tpls, ctx, emitter);
    emitter.write("</div>");
  },
});
engine.registerFilter("add", (initial, arg1, arg2) => initial + arg1 + arg2);
engine.renderFile("tag", {}).then((html) => {
  writeFileSync(path.join(outputDir, "tag.html"), html, {
    encoding: "utf-8",
  });
});
