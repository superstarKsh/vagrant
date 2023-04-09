# vagrant 실습 
1. Install 
  - https://www.virtualbox.org/
  - https://www.vagrantup.com/?product_intent=consul
2. 실행 
  - vagrant up
  - /vagrant/join.sh 파일을 각 work nodes에 실행 
  ```
  # 기타 명령어
  - vagrant 명령어 : [init, box add ${host_box}, box list, box remove ${host_box}, up, suspend, halt, ssh, destory]
  - suspend: 실행상태를 저장하여 중단, halt: 게스트 운영체지/시스템 전원을 끔 완전정지, destory: 가상머신을 완전삭제.
  - local및 guest file 동기화 : vagrant ssh > cd /vagrant 
  - 로컬 vagrant 폴더와 공유됨 
  ```
3. 설정 
  - kubernetes, containerd, ubuntu, CNI(calico)
4. 프로텍트 설명 (mgmt, ubuntu-k8s)
  - baseOS: https://github.com/chef/bento 
    - version: ubuntu-20.04    
  - 실습용 k8s 구성 
    - master and node (containerd, k8s)
    - master(calico)    
    - port nodes[master-192.168.56.10:60010, worker1-192.168.56.11:60011, worker2-192.168.56.12:60012 ... ]
    - node-ips=[192.168.56.1x...], pod-network-cider=10.244.0.0/16
  - mgmt 유틸리티 서버 셋팅 
    - curl, jq, docker, mysql-client, python3, k9s, kubectl, helm 
    - port[192.168.56.1:60005]
5. 이슈 
  - vm off시 swapoff disabled.. (why? https://medium.com/tailwinds-navigator/kubernetes-tip-why-disable-swap-on-linux-3505f0250263) 
  ```
    # 임시조치 
    sudo /etc/init.d/disabled-swap.sh
  ```
  - local Computer에서 접근하기 위한 : https://developer.hashicorp.com/vagrant/docs/networking/forwarded_ports#guest_ip  
  
99. 참고 
   - https://github.com/pyrasis/jHLsKubernetes/blob/main/Unit06/Vagrantfile#L71
   - https://gist.github.com/lesstif/8185f143ba7b8881e767900b1c8e98ad?permalink_comment_id=2857318#file-change-ubuntu-mirror-sh

