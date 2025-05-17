import PreferencesUtil from '../common/database/PreferenceUtil';
import LoggingUtil from '../common/utils/logging';
import { promptAction } from '@kit.ArkUI';

@Extend(TextInput)
function inputStyle() {
  .placeholderColor('#33182431')
  .height('45vp')
  .fontSize('18fp')
  .backgroundColor('#F1F3F5')
  .width('100%')
  .margin({ top: 12 })
}

@Extend(Line)
function lineStyle() {
  .width('100%')
  .height('1vp')
  .backgroundColor('#33182431')
}

@Entry
@Component
struct LoginPage {

  packStack: NavPathStack = new NavPathStack()

  @State username: string = '';
  @State password: string = '';
  @State isRememberUser: boolean = false
  @State isLoading: boolean = false

  aboutToAppear() {
    LoggingUtil.info(0x0000, 'test', '%{public}s', 'start')
    const loginUser = PreferencesUtil.getLoginUser()
    LoggingUtil.info(0x0000, 'test', '%{public}s', `user: ${loginUser}`)
    if (loginUser) {
      this.isRememberUser = true
      this.username = loginUser
    }
  }

  loginClick() {
    if (this.username === 'user' && this.password === '123456') {
      this.isLoading = true
      setTimeout(() => {
        this.isLoading = false
        this.packStack.pushPathByName('mainPage', null)
      }, 2000)
    } else {
      promptAction.showToast({
        message: $r('app.string.login_confirm_error_tips')
      })
    }
  }

  build() {
    Navigation(this.packStack) {
      Column() {
        Column() {
          Image($r('app.media.startIcon'))
            .width('78vp')
            .height('78vp')
            .margin({ bottom: '12vp' })
          Text($r('app.string.login_title'))
            .fontColor('#333')
            .fontSize('24vp')
            .fontWeight(600)
            .margin({ bottom: '8vp' })
          Text($r('app.string.login_description'))
            .fontColor('#999')
            .fontSize('16vp')
          TextInput({ placeholder: $r('app.string.Login_User_PlaceHolder'), text: this.username })
            .maxLength(11)
            .inputStyle()
            .onChange((value: string) => {
              this.username = value;
              if (value && this.isRememberUser) {
                PreferencesUtil.saveLoginUser(value);
              }
            })
          Line()
            .lineStyle()
          TextInput({ placeholder: $r('app.string.Login_Password_PlaceHolder'), text: this.password })
            .type(InputType.Password)
            .inputStyle()
            .onChange((value: string) => {
              this.password = value;
            })
          Line()
            .lineStyle()
          Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
            Row() {
              Checkbox({ name: 'isRememberUser' })
                .select(this.isRememberUser)
                .shape(CheckBoxShape.ROUNDED_SQUARE)
              Text($r('app.string.login_remember_user'))
            }
            Text($r('app.string.forget_password'))
          }
          .width('100%')
          .margin({ top: '12vp' })
          .onClick(() => {
            this.isRememberUser = !this.isRememberUser
            if (this.isRememberUser && this.username) {
              PreferencesUtil.saveLoginUser(this.username)
            }
          })
          Button($r('app.string.login_button'))
            .type(ButtonType.ROUNDED_RECTANGLE)
            .width('40%')
            .margin({ top: '24vp' })
            .backgroundColor($r('app.color.theme_color'))
            .borderRadius(16)
            .onClick(() => {
              LoggingUtil.info(0x0000, 'test', '%{public}s', 'click')
              this.loginClick()
            })


        }


      }
      .width('100%')
      .height('100%')
      .padding({ left: '24vp', right: '24vp' })
      .justifyContent(FlexAlign.Center)

      if (this.isLoading) {
        Column() {
          LoadingProgress()
            .color('#182431')
            .width('30vp')
            .height('30vp')
        }
        .width('100%')
        .position({ top: '45%' })
        .alignItems(HorizontalAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .hideTitleBar(true)
    .hideToolBar(true)
    .backgroundColor('#F1F3F5')
    .mode(NavigationMode.Stack)
  }
}