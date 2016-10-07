import teradata
from flask import Flask
from flask import jsonify
import os

app = Flask(__name__)

port = int(os.getenv("PORT"))

@app.route('/')
def CreateTDConnection():
    try:
        udaExec = teradata.UdaExec(appConfigFile='TDConfig.ini', logLevel="DEBUG", configureLogging=True)

        kw = {"ANSI":True}

        session = udaExec.connect(
            password="pwd",
            driver="Teradata",
            method="odbc",
            charset="UTF8",
            username="uid",
            system="terdatahost",
            **kw
        )

        print('Teradata Connection Sucessful')
        return jsonify(status='Success')
    except Exception as e:
        print ('CreateTDConnection:Failed to Conect to teradata server', e)
        return jsonify(status='Failed', error=e.code, message=e.msg, sqlstate=e.sqlState)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=port)
