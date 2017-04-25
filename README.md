# NSKit
这是一个链式编程库

集成了系统的大多数 UI 控件, 使用非常方便

先上一段代码给你看看:

self.demoLabel
    .ns_init
    .title(@"谷工，你好啊，最近忙吗？这周会空一点吗？可以耽误你们半个小时介绍一下公司吗？")
    .textColor([UIColor blackColor])
    .textAlignment(@(NSTextAlignmentCenter))
    .textFont([UIFont systemFontOfSize:15])
    .lineNumber(@(2))
    .attributed(@"这周", @{NSForegroundColorAttributeName:[UIColor redColor]})
    .attributed(@"耽误", @{NSFontAttributeName:[UIFont systemFontOfSize:17]})
    .attributed(@"谷工，你好啊，最近忙吗？这周会空一点吗？可以耽误你们半个小时介绍一下公司吗？", @{NSParagraphStyleAttributeName:paragraphStyle})
    .addOnView(self.view);
