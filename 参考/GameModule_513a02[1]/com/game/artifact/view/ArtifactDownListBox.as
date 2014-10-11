package com.game.artifact.view
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ArtifactDownListBox extends EventDispatcher
    {
        private var bg:DisplayObject;
        private var label:TextField;
        private var button:BaseButton;
        private var listContainer:DisplayObjectContainer;
        private var listView:List;
        private var data:Array;

        public function ArtifactDownListBox(param1:DisplayObject, param2:TextField, param3:BaseButton, param4:DisplayObjectContainer)
        {
            this.bg = param1;
            this.label = param2;
            this.button = param3;
            this.listContainer = param4;
            param4.visible = false;
            param2.addEventListener(MouseEvent.CLICK, this.onPulldown);
            param3.addEventListener(MouseEvent.CLICK, this.onPulldown);
            FrameworkGlobal.stage.addEventListener(MouseEvent.CLICK, this.onStageClick);
            param4.x = param1.x;
            param4.y = param1.y + param1.height;
            this.listView = new List(param3.x + param3.width - param2.x, param4.height - 4);
            this.listView.x = param2.x - param1.x;
            this.listView.y = 2;
            param4.addChild(this.listView);
            return;
        }// end function

        public function getListView() : List
        {
            return this.listView;
        }// end function

        public function setVisible(param1:Boolean) : void
        {
            this.bg.visible = param1;
            this.label.visible = param1;
            this.button.visible = param1;
            if (!param1)
            {
                this.listContainer.visible = false;
            }
            return;
        }// end function

        private function onStageClick(event:MouseEvent) : void
        {
            if (this.listContainer.hitTestPoint(event.stageX, event.stageY) || this.label.hitTestPoint(event.stageX, event.stageY) || this.button.hitTestPoint(event.stageX, event.stageY))
            {
                return;
            }
            if (this.listContainer.visible)
            {
                this.listContainer.visible = false;
            }
            return;
        }// end function

        private function onPulldown(event:MouseEvent) : void
        {
            this.listContainer.visible = !this.listContainer.visible;
            return;
        }// end function

        public function set dataProvider(param1:Array) : void
        {
            var _loc_3:* = null;
            this.data = param1;
            var _loc_2:* = 0;
            while (_loc_2 < this.data.length)
            {
                
                _loc_3 = this.createItem();
                _loc_3.addEvtListener(MouseEvent.CLICK, this.onItemClick);
                _loc_3.obj = this.data[_loc_2];
                this.listView.add(_loc_3);
                _loc_2++;
            }
            return;
        }// end function

        private function createItem() : ArtifactDownListBoxItem
        {
            return new ArtifactDownListBoxItem(this.label.width, this.label.defaultTextFormat.align);
        }// end function

        private function onItemClick(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as IItem;
            this.label.text = _loc_2.label;
            this.listContainer.visible = false;
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function get selectIndex() : int
        {
            return this.listView.selectIndex;
        }// end function

        public function set selectIndex(param1:int) : void
        {
            var _loc_2:* = null;
            if (this.data && param1 < this.data.length)
            {
                _loc_2 = this.data[param1];
                this.listView.selectIndex = param1;
                this.label.text = _loc_2.label;
            }
            return;
        }// end function

        public function get selectItem() : IItem
        {
            return this.listView.selectItem;
        }// end function

    }
}
