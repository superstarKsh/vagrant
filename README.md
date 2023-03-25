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
  - 실습용 k8s 구성 
    - master and node (containerd, k8s)
    - master(calico)    
  - mgmt 유틸리티 서버 셋팅 
    - curl, jq, docker, mysql-client, python3, k9s, kubectl, helm 
5. 참고 
   - https://github.com/pyrasis/jHLsKubernetes/blob/main/Unit06/Vagrantfile#L71
   - https://gist.github.com/lesstif/8185f143ba7b8881e767900b1c8e98ad?permalink_comment_id=2857318#file-change-ubuntu-mirror-sh

