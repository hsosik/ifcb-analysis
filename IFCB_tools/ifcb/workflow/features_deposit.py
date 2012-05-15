from oii.workflow.deposit import app, DirectoryStorage, STORAGE
from oii.config import get_config
import re

if __name__=='__main__':
    config = get_config('./features_deposit.conf')
    app.config[STORAGE] = DirectoryStorage(config)
    (h,p) = re.match(r'http://(.*):(\d+)',config.features_deposit).groups()
    app.run(host=h, port=int(p))
