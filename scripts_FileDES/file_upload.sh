#!/bin/bash

MINER1=$1
MINER2=$2
MINER3=$3

./lotus client import testdata/v1
./lotus client import testdata/patch1
./lotus client import testdata/patch2  
./lotus client import testdata/patch3
./lotus client import testdata/patch4
./lotus client import testdata/patch5
./lotus client import testdata/patch6
./lotus client import testdata/patch7
./lotus client import testdata/patch8  
./lotus client import testdata/patch9  
./lotus client import testdata/patch10
./lotus client import testdata/patch11
./lotus client import testdata/patch12 
./lotus client import testdata/patch13
./lotus client import testdata/patch14
./lotus client import testdata/patch15 
./lotus client import testdata/patch16
./lotus client import testdata/patch17
./lotus client import testdata/patch18
./lotus client import testdata/patch19

./lotus client deal bafykbzaceaanrd4jqhaaalcbsftfzzc7wfi6o7qk27hnjlhfmv72qeeokgtni "$MINER1" 0.026 518400
sleep 60
./lotus client deal bafk2bzaceaox2bgqudb7o2wq7ra444fshsb7iedtic4htq2c63t4ysr77uzfk "$MINER2" 0.026 518400
sleep 60
./lotus client deal bafk2bzacebjm5xaqy7sdklvzyhojz4swfgjqhh5lxzroa7zej4slm3bmgopzi "$MINER3" 0.026 518400
sleep 60
./lotus client deal bafk2bzaceakuk27pkmvujotenfi3r4gousl54rhm4g3whua4t45hm3tx4g35u "$MINER1" 0.026 518400
sleep 60
./lotus client deal bafykbzaceblch66l7x5cyy7dtsu3kztivcej3w27phpoa5ympm5aaqoqpxg6w "$MINER2" 0.026 518400
sleep 60
./lotus client deal bafykbzacedxofpmojhg2cnxpkuf7mrskjttj3qrmeaurouy4pjl6xeduwcpaa "$MINER3" 0.026 518400
sleep 60
./lotus client deal bafykbzaced6pdjiz5fxe43y46yrblytad37ka3x3s6se55buxyjgwyeflwuka "$MINER1" 0.026 518400
sleep 60
./lotus client deal bafykbzacedailkssqucf2wrwyswmogv2ctyc5axqjwwuhnnrkklpwzd3nuxbw "$MINER2" 0.026 518400
sleep 60
./lotus client deal bafk2bzacebnp4a3iyxyiw7oy75rlsiifxaqbnfwhcol5wiox6ssbyq4tecjg4 "$MINER3" 0.026 518400
sleep 60
./lotus client deal bafk2bzacedagt7gfqh554fb67j4fnmsxbspb6kvgnmbdfeayyeao475zhsany "$MINER1" 0.026 518400
sleep 60
./lotus client deal bafykbzaceayofd7n7z2uteatqfrpm4tcuuveau6jyhi2ebnjmhxkknwfkuhhk "$MINER2" 0.026 518400
sleep 60
./lotus client deal bafykbzacebxthmlde72f377vdlip6qog6ykwzo55yge6kl2ejhiampuqlscnc "$MINER3" 0.026 518400
sleep 60
./lotus client deal bafk2bzaceaiujz65xvzdss27dics4kk3p3xnjfsb3wwkyuumh75zg4bwk6w3c "$MINER1" 0.026 518400
sleep 60
./lotus client deal bafk2bzaceaxljouclc5zf4mgj5uvyl3apspkvs67bhyqabki7hejypcmlwqre "$MINER2" 0.026 518400
sleep 60
./lotus client deal bafykbzaceaktgutg4taes5bci3jx27e6bnlyd6wqgyiip43ligm2pbhhqvz4s "$MINER3" 0.026 518400
sleep 60
./lotus client deal bafk2bzaceahykbdkzn7y4yrolg7u35nfcgezufzupb5y2rzwqdorzpurhwbsk "$MINER1" 0.026 518400
sleep 60
./lotus client deal bafk2bzacecwvcalrp7bxnefzuit57bwiycmhusriu6hj4ipp7ijw2ugtf55tu "$MINER2" 0.026 518400
sleep 60
./lotus client deal bafykbzacecsjbrfhic5wtv2466gct2qcgdadvevb6bk64v2ecatn2iand4zgg "$MINER3" 0.026 518400
sleep 60
./lotus client deal bafykbzacebmhcjt4ko6ydlz2aas7dy6g6udjsk5qo3yxljba564cdlsajmh3y "$MINER1" 0.026 518400
sleep 60
./lotus client deal bafykbzacedtmnvuboiaqldbpglivhvpj75x2yu46grvlalks22nchgyc4qdye "$MINER2" 0.026 518400







