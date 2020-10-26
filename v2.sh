pip install pandas==0.24.2 &> tmp.log
pip install regex==2019.4.14 &> tmp.log
pip install h5py==2.10.0 &> tmp.log
pip install numpy==1.18.4 &> tmp.log
pip install tensorboard==1.15.0 &> tmp.log
pip install tensorflow-gpu==1.15.2 &> tmp.log
pip install tensorflow-estimator==1.15.1 &> tmp.log
pip install tqdm==4.31.1 &> tmp.log
pip install requests==2.22.0 &> tmp.log
pip install ujson==2.0.3 &> tmp.log
cd /home
git clone -b master https://github.com/EssayKillerBrain/EssayKiller_V2.git 
mkdir -p /home/EssayKiller_V2/LanguageNetwork/GPT2/finetune/trained_models
cd /home/EssayKiller_V2/LanguageNetwork/GPT2/finetune/
perl /home/EssayKiller_V2/LanguageNetwork/GPT2/scripts/gdown.pl https://drive.google.com/open?id=1ujWYTOvRLGJX0raH-f-lPZa3-RN58ZQx trained_models/model.ckpt-280000.data-00000-of-00001
wget -q --show-progress https://github.com/EssayKillerBrain/EssayKiller/releases/download/v1.0/model.ckpt-280000.index -P /home/EssayKiller_V2/LanguageNetwork/GPT2/finetune/models/mega
wget -q --show-progress https://github.com/EssayKillerBrain/EssayKiller/releases/download/v1.0/model.ckpt-280000.meta -P /home/EssayKiller_V2/LanguageNetwork/GPT2/finetune/models/mega
作文最小篇幅 = 800
生成作文篇数 = 1
mv /home/EssayKiller_V2/LanguageNetwork/GPT2/finetune/models/mega/* /home/EssayKiller_V2/LanguageNetwork/GPT2/finetune/trained_models/
cd /home/EssayKiller_V2/LanguageNetwork/GPT2/
export TF_CPP_MIN_LOG_LEVEL=2
echo '模型加载中，请稍后......'
PYTHONPATH=$(pwd) python scripts/demo.py -ckpt_fn finetune/trained_models/model.ckpt-280000 -min_len $作文最小篇幅 -samples $生成作文篇数
PYTHONPATH=$(pwd) python scripts/formatter.py -org_text result.txt