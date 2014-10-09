package com.view.ui.list
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;

    public class ListItem extends BaseSprite implements IItem
    {
        protected const COLOR_NORMAL:uint = 16766079;
        protected const COLOR_SELECT:uint = 65532;
        protected var _content:MovieClip;
        private var mcBack:MovieClip;
        private var _selected:Boolean = false;
        protected var _className:String;
        private var _index:uint;
        private var _obj:Object;
        private var _bg:String;

        public function ListItem(param1:String, param2:String = "back")
        {
            this._bg = param2;
            this._className = param1;
            this.initItem();
            this.addEvents();
            return;
        }// end function

        public function get key()
        {
            return this._index;
        }// end function

        public function get obj()
        {
            return this._obj;
        }// end function

        public function set obj(param1) : void
        {
            this._obj = param1;
            this.receive();
            return;
        }// end function

        public function get label() : String
        {
            return null;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            this._selected = param1;
            if (param1)
            {
                if (this.mcBack)
                {
                    this.mcBack.gotoAndStop(4);
                }
            }
            else if (this.mcBack)
            {
                this.mcBack.gotoAndStop(this.index % 2 == 0 ? (1) : (2));
            }
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._selected;
        }// end function

        private function setBackFrame(param1:int) : void
        {
            if (this.mcBack)
            {
                this.mcBack.gotoAndStop(param1);
            }
            return;
        }// end function

        public function get index() : uint
        {
            return this._index;
        }// end function

        public function set index(param1:uint) : void
        {
            this._index = param1;
            this.setBackFrame(this._index % 2 == 0 ? (1) : (2));
            return;
        }// end function

        private function initItem() : void
        {
            if (this._className && this._className.length > 0)
            {
                this._content = ToolKit.getNew(this._className);
                if (this._bg != "")
                {
                    this.mcBack = this._content.getChildByName(this._bg) as MovieClip;
                }
                this.addChild(this._content);
            }
            this.getComp();
            return;
        }// end function

        protected function addEvents() : void
        {
            if (!this.hasEventListener(MouseEvent.MOUSE_OVER))
            {
                this.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOverHandler);
                this.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOutHandler);
            }
            return;
        }// end function

        protected function mouseOverHandler(event:MouseEvent) : void
        {
            if (!this.selected)
            {
                if (this.mcBack)
                {
                    this.mcBack.gotoAndStop(3);
                }
            }
            return;
        }// end function

        protected function mouseOutHandler(event:MouseEvent) : void
        {
            if (!this.selected)
            {
                if (this.mcBack)
                {
                    this.mcBack.gotoAndStop(this.index % 2 == 0 ? (1) : (2));
                }
            }
            return;
        }// end function

        protected function getComp() : void
        {
            throw new Error("方法getComp（）需重载:" + this);
        }// end function

        protected function receive() : void
        {
            throw new Error("方法receive（）需重载:" + this);
        }// end function

    }
}
