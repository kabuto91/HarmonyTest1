
@Builder
export function mainPageBuilder() {
  mainPage()
}

@Preview
@Component
export struct mainPage {
  @State pathStack: NavPathStack = new NavPathStack()

  build() {
    NavDestination() {
      Tabs({ barPosition: BarPosition.End }) {
        TabContent() {

        }
        .tabBar('test')

        TabContent() {

        }
        .tabBar('test1')
      }
      .width('100%')
      .height('100%')
      .barMode(BarMode.Fixed)
      .vertical(false)
    }
    .height('100%')
    .hideTitleBar(true)
    .onReady((context: NavDestinationContext) => {
      this.pathStack = context.pathStack
    })
  }
}