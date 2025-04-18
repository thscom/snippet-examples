import { preferences } from '@kit.ArkData'
import { BusinessError } from '@kit.BasicServicesKit'
import { hilog } from '@kit.PerformanceAnalysisKit'

const PREFERENCE_NAME = 'ArkUIExample'
const TAG = 'PreferencesUtil'
const LOG_DOMAIN = 0x0000

export class PreferencesUtil {
  preference?: preferences.Preferences

  getPreference(context: Context) {
    this.preference = preferences.getPreferencesSync(context, {
      name: PREFERENCE_NAME
    })
    hilog.info(LOG_DOMAIN, TAG, 'create preference success')
  }

  isKeyExist(key: string): boolean {
    let isKeyExist: boolean = false
    this.preference?.has(key).then(
      async (isExist: boolean) => {
        isKeyExist = isExist
      }
    ).catch((err: Error) => {
      hilog.error(LOG_DOMAIN, TAG, `Failed to check key. message = ${err.message}`)
    })
    return isKeyExist
  }

  getValue(key: string, defVal: preferences.ValueType): Optional<preferences.ValueType> {
    if (!this.isKeyExist(key)) return undefined
    return this.preference?.getSync(key, defVal)
  }

  setValue(key: string, value: preferences.ValueType) {
    this.preference?.putSync(key, value)
    this.preference?.flush(
      (err: BusinessError) => {
        if (err) {
          hilog.error(LOG_DOMAIN, TAG, `Failed to flush. code = ${err.code}, message = ${err.message}`)
          return
        }
        hilog.info(LOG_DOMAIN, TAG, `Succeeded in flushing: ${key}`)
      }
    )
  }
}

export default new PreferencesUtil()