 //点击节点
 console.log(stationSelector)
 stationSelector.TreeOnClick=function (event, treeId, treeNode) {
     //判断
     console.log(treeNode.tId + ", " + treeNode.name);
     let arr = treeNode.tId.split("_");
     console.log(arr[1]);
 };