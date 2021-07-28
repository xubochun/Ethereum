# Ethereum

創世區塊(genesis.json) 請參考 https://xubonote.blogspot.com/2021/07/blog-post.html 文章建立以太坊的私有鏈。

> 常用指令

1. 啟動碼
```
geth --identity "TestNode" --networkid 95518 --rpc --rpcport "8545" --port "30303" --rpccorsdomain "*" --rpcapi "eth,net,web3,personal,web3" --nodiscover console
```

2. 挖礦(驗證)
```
miner.start(); admin.sleepBlocks(1); miner.stop();
```

3. 狀態
```
web3.txpool.status
```

4. 節點資訊
```
admin.nodeInfo.enode
```

5. 連接節點指令
```
admin.addPeer("enode://...")
```

6. 查看連結的節點數量
```
web3.net.peerCount
```

