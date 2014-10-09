package com.f1.ui.box
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class DownListBox extends EventDispatcher
    {
        private var textField:TextField;
        private var button:BaseButton;
        private var container:DisplayObjectContainer;
        private var bg:DisplayObject;
        private var listMC:List;
        private var data:Array;
        private var renderClass:Class;

        public function DownListBox(param1:TextField, param2:BaseButton, param3:DisplayObjectContainer, param4:DisplayObject = null)
        {
            this.renderClass = BaseButton;
            this.textField = param1;
            this.button = param2;
            this.container = param3;
            this.bg = param4;
            param2.addEventListener(MouseEvent.CLICK, this.onMouseClick);
            FrameworkGlobal.stage.addEventListener(MouseEvent.CLICK, this.onStageClick);
            param3.x = param2.x + param2.width - param3.width + 3;
            param3.y = param2.y + param2.height;
            this.listMC = new List(param3.width - 4, param3.height - 4);
            this.listMC.x = 2;
            this.listMC.y = 2;
            param3.addChild(this.listMC);
            return;
        }// end function

        public function getListView() : List
        {
            return this.listMC;
        }// end function

        public function setVisible(param1:Boolean) : void
        {
            if (this.bg != null)
            {
                this.bg.visible = param1;
            }
            this.textField.visible = param1;
            this.button.visible = param1;
            if (!param1)
            {
                this.container.visible = false;
            }
            return;
        }// end function

        private function onStageClick(event:MouseEvent) : void
        {
            var _loc_2:* = this.container.hitTestPoint(event.stageX, event.stageY);
            if (_loc_2)
            {
                return;
            }
            _loc_2 = this.button.hitTestPoint(event.stageX, event.stageY);
            if (_loc_2)
            {
                return;
            }
            if (this.container.visible)
            {
                this.container.visible = false;
            }
            return;
        }// end function

        private function onMouseClick(event:MouseEvent) : void
        {
            this.container.visible = !this.container.visible;
            return;
        }// end function

        private function onRollOut(event:MouseEvent) : void
        {
            this.container.visible = false;
            return;
        }// end function

        public function set render(param1:Class) : void
        {
            this.renderClass = param1;
            return;
        }// end function

        public function set dataProvider(param1:Array) : void
        {
            var _loc_3:* = null;
            this.data = param1;
            var _loc_2:* = 0;
            while (_loc_2 < this.data.length)
            {
                
                _loc_3 = new this.renderClass();
                _loc_3.addEvtListener(MouseEvent.CLICK, this.onItemClickHandle);
                _loc_3.obj = this.data[_loc_2];
                this.listMC.add(_loc_3);
                _loc_2++;
            }
            return;
        }// end function

        private function onItemClickHandle(event:MouseEvent) : void
        {
            var _loc_2:* = event.currentTarget as IItem;
            this.textField.text = _loc_2.label;
            this.container.visible = false;
            dispatchEvent(new Event(Event.CHANGE));
            return;
        }// end function

        public function get selectIndex() : int
        {
            return this.listMC.selectIndex;
        }// end function

        public function set selectIndex(param1:int) : void
        {
            var _loc_2:* = null;
            if (this.data && param1 < this.data.length)
            {
                _loc_2 = this.data[param1];
                this.listMC.selectIndex = param1;
                this.textField.text = _loc_2.label;
            }
            return;
        }// end function

        public function get selectItem() : IItem
        {
            return this.listMC.selectItem;
        }// end function

    }
}
