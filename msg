import time
import pyupbit
import datetime
import requests
import schedule

myToken = "xoxb-2051832874548-2042595187461-BBXrlfBOrIWt0uAlF3NXMAyd"

def post_message():
    now = datetime.datetime.now()
    t = int(now.strftime('%H'))
    df_btc = pyupbit.get_daily_ohlcv_from_base("KRW-BTC", base=t)
    target_price_btc = df_btc.iloc[8]['close'] + (df_btc.iloc[8]['high'] - df_btc.iloc[8]['low']) * 0.4
    df_doge = pyupbit.get_daily_ohlcv_from_base("KRW-DOGE", base=t)
    target_price_doge = df_doge.iloc[8]['close'] + (df_doge.iloc[8]['high'] - df_doge.iloc[8]['low']) * 0.4
    response = requests.post("https://slack.com/api/chat.postMessage",
        headers={"Authorization": "Bearer "+ "xoxb-2051832874548-2042595187461-BBXrlfBOrIWt0uAlF3NXMAyd"},
        data={"channel": "#stock","text": "BTC 목표가 : " + str(target_price_btc) + "\nDOGE 목표가 : " + str(target_price_doge)}
    )



if __name__=='__main__':
    #schedule.every().day.at("21:55").do(post_message)
    post_message()
    schedule.every(60).minutes.do(post_message)

    while True:
        schedule.run_pending()
        time.sleep(1)
 




