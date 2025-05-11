import { preferences } from "@kit.ArkData";
import LoggingUtil from '../utils/logging'
import { BusinessError } from "@kit.BasicServicesKit";

// logging
const domain: number = 0x0000
const tag: string = 'PreferencesUtil'

// preferenceCode
const LOGIN_USER = 'loginUser'

export class PreferencesUtil {
  preference?: preferences.Preferences

  getUserPreferences(context: Context) {
    this.preference = preferences.getPreferencesSync(context, { name: 'userPreferences' })
    LoggingUtil.info(domain, tag, '%{public}s', 'init userPreferences success')
  }

  saveLoginUser(loginUser: string) {
    LoggingUtil.info(domain, tag, '%{public}s', `loginUser: ${loginUser}`)
    this.preference?.putSync(LOGIN_USER, loginUser);
    this.preference?.flush((error: BusinessError) => {
      if (error) {
        LoggingUtil.error(domain, tag, `Failed to flush isRememberUser. code = ${error.code}, message = ${error.message}`);
        return;
      }
      LoggingUtil.info(domain, tag, 'Success in flushing isRememberUser.');
    })
  }

  getLoginUser() {
    let loginUser: string = '';
    loginUser = this.preference?.getSync(LOGIN_USER, '') as string;
    return loginUser;
  }
}

export default new PreferencesUtil();