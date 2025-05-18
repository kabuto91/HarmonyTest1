
@Builder
export function mainPageBuilder() {
  mainPage()
}

@Entry
@Component
export struct mainPage {
  @State pathStack: NavPathStack = new NavPathStack()
  @State selectedIndex: number = 0
  private tabsController: TabsController = new TabsController()

  @Builder
  TabContentBuilder(text: Resource, index: number, image: Resource) {
    Column() {
      SymbolGlyph(image)
        .renderingStrategy(SymbolRenderingStrategy.MULTIPLE_OPACITY)
        .fontColor([index === this.selectedIndex ? $r('app.color.theme_color') : $r('app.color.image_unSelected_color')])
        .fontSize('24vp')
      Text(text)
        .margin({ top: '4vp' })
        .fontSize('14vp')
        .fontWeight(500)
        .fontColor(index === this.selectedIndex ? $r('app.color.theme_color') : $r('app.color.font_color'))
    }
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      this.selectedIndex = index
      this.tabsController.changeIndex(this.selectedIndex)
    })
  }

  build() {
    NavDestination() {
      Tabs({
        barPosition: BarPosition.End,
        controller: this.tabsController
      }) {
        TabContent() {
          Column() {
            Text('主页')
          }
        }
        .tabBar(this.TabContentBuilder($r('app.string.tab_title_home'), 0, $r('sys.symbol.house_fill')))

        TabContent() {
          Column() {
            Text('我的')
          }
        }
        .tabBar(this.TabContentBuilder($r('app.string.tab_title_mime'), 1, $r('sys.symbol.person_crop_circle_fill_1')))
      }
      .width('100%')
      .height('100%')
      .barMode(BarMode.Fixed)
      .vertical(false)
      .divider({ strokeWidth: '1vp' })
      .onChange((index: number) => {
        this.selectedIndex = index
      })
    }
    .height('100%')
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}