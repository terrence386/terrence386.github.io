###### 页面导入样式时，使用link和@import有什么区别？
- 1.link是HTML标签，@import是css提供的。
- 2.link引入的样式页面加载时同时加载，@import引入的样式需等页面加载完成后再加载。
- 3.link没有兼容性问题，@import不兼容ie5以下。
- 4.link可以通过js操作DOM动态引入样式表改变样式，而@import不可以。

###### 视区窗口viewport
viewport 就是视区窗口，也就是浏览器中显示网页的部分。PC 端上基本等于设备显示区域，但在移动端上 viewport 会超出设备的显示区域（即会有横向滚动条出现）。
设备默认的 viewport 在 980 - 1024 之间。

为了让移动端可以很好地显示页面，因此需要对 viewport 进行设置。相关的设置值如下：
- width	设置 layout viewport 的宽度，为一个正整数，或字符串"width-device"
- initial-scale	设置页面的初始缩放值，为一个数字，可以带小数
- minimum-scale	允许用户的最小缩放值，为一个数字，可以带小数
- maximum-scale	允许用户的最大缩放值，为一个数字，可以带小数
- height	设置 layout viewport 的高度，这个属性对我们并不重要，很少使用
- user-scalable	是否允许用户进行缩放，值为"no"或"yes", no 代表不允许，yes 代表允许

相关的衍生知识： dpr 与 CSS 像素。CSS 像素的 1px 在 PC 端上与设备的物理像素基本一致，而到手机端就会有两个物理像素对应一个 CSS 像素的情况出现（如 iPhone 的视网膜屏）。
所以 iPhone 上的 dpr = 2 即 2 个物理像素 / 一个 CSS 像素（独立像素）

###### HTML元素优先级
在html中，帧元素（frameset）的优先级最高，表单元素比非表单元素的优先级要高。
- 表单元素:
文本输入框，密码输入框，单选框，复选框，文本输入域，列表框等等
- 非表单元素
链接（a），div, table, span 等等

有窗口元素比无窗口元素的优先级高

有窗口元素

- select元素，object元素，以及frames元素等等

无窗口元素
- 大部分html元素都是无窗口元素