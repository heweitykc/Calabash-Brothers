package com.f1.ui.tree
{
    import __AS3__.vec.*;
    import com.f1.ui.list.*;
    import flash.display.*;
    import flash.events.*;

    public class Tree extends List
    {
        private var _treeItem:TreeItem;
        private var _branch:Vector.<TreeItem>;

        public function Tree(param1:uint = 100, param2:uint = 200, param3:String = null, param4:String = "scrollBar1")
        {
            super(param1, param2, param3, param4);
            this._branch = new Vector.<TreeItem>;
            return;
        }// end function

        public function get branch() : Vector.<TreeItem>
        {
            return this._branch;
        }// end function

        public function set branch(param1:Vector.<TreeItem>) : void
        {
            this._branch = param1;
            return;
        }// end function

        public function addTreeItem(param1:String, param2:uint = 16773804, param3:String = null, param4:uint = 6737151, param5:Boolean = true) : TreeItem
        {
            this._treeItem = new TreeItem(param1, param2, param3, param4, param5);
            this._treeItem.addEvtListener(Event.CHANGE, this.itemChange);
            this.add(this._treeItem);
            this._branch.push(this._treeItem);
            return this._treeItem;
        }// end function

        public function addTreeItemAt(param1:int, param2:String, param3:uint = 16773804, param4:String = null, param5:uint = 6737151, param6:Boolean = true) : void
        {
            this._treeItem = new TreeItem(param2, param3, param4, param5, param6);
            this._treeItem.addEvtListener(Event.CHANGE, this.itemChange);
            this.addAt(this._treeItem, param1);
            return;
        }// end function

        public function addSecondItem(param1:DisplayObject, param2:int) : void
        {
            (this._box.getContent(param2) as TreeItem).addItem(param1);
            return;
        }// end function

        public function getTreeItemByIndex(param1:int) : TreeItem
        {
            return this._box.getContent(param1) as TreeItem;
        }// end function

        public function setTreeItemUnfoldByIndex(param1:int) : void
        {
            this.getTreeItemByIndex(param1).unfold();
            return;
        }// end function

        public function setTreeItemFoldByIndex(param1:int) : void
        {
            this.getTreeItemByIndex(param1).fold();
            return;
        }// end function

        public function setTreeItemBgWidthByIndex(param1:int, param2:int) : void
        {
            this.getTreeItemByIndex(param1).setTreeItemBgWidth(param2);
            return;
        }// end function

        private function itemChange(event:Event) : void
        {
            this.update();
            return;
        }// end function

        override public function reset() : void
        {
            super.reset();
            return;
        }// end function

    }
}
