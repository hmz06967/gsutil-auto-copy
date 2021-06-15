# gsutil-auto-copy

Auto Cloud Storage Upload Shell

Belirlediğiniz yollara göre, Google Cloud Storage'ye otomatik upload eder ve dosyayı yerel dosya sisteminden siler.

# Auto

Kopyalama log detayları  tail -f $upload_file bu komut ile görebilirsiniz. Çıkmak için Ctrl-C 
    
    tail -f upload.log

# Config

Bu dosyanın içerisindeki komutları kendinize göre düzenleyin. pr_on=1 komutunu eklerseniz upload.log, ip.log dosyalarını karşı sunucuya her 10 dk da bir atar.

Bir kez başlatmanız yeterli daha sonrasında $cnum sayıda otomatik yol kontrolü  yapar dosya sisteminde bulunan örn "*.plot" adındaki dosyaları $json_path GOOGLE auth dosyasınıı kullnarak bir kez auth olunan projenizdeki buckup'a yükleme yapar.

Önerilen: temp kalsörünün bir tanesini ram olarak 101Gib mount ederseniz [madmax plotter=1] 40dk da plot hızına ulaşma imkanı vardır.

    # [INPUT]
    # Gcloud path 
    gpath=gs://rrbot_a1/yuksek # storage buckup name 
    json_file=""  # google authencation json, url or path 

    # crontap run time (min)
    cnum=10 #10dk

    # connect host for progress from scp 
    pr_on=0
    prog_host="" # host 
    pass="" # host password
    user="root" # host user
    prog_path="/root/progress/"
    $prog_path1=$prog_path

    # [START]
    # Log files
    plot_file="/root/plot.log"
    up_file="/root/upload.log"

# Install 

Aşağıdan linux ubuntu için yükleme adımlarını gerçekleştirin.

# Lİnux/Ubuntu

    git clone https://github.com/hmz06967/gsutil-auto-copy | bash gsutil-auto-copy/gsauto.sh
