package com.game.team.view
{
    import com.f1.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;

    public class ListItemBase extends BaseSprite
    {
        protected const COLOR_NORMAL:uint = 16766079;
        protected const COLOR_SELECT:uint = 65532;
        protected var _content:MovieClip;
        protected var mcBack:MovieClip;
        private var _selected:Boolean = false;
        protected var _className:String;
        protected var _index:int;

        public function ListItemBase(param1:String)
        {
            this._className = param1;
            this.initItem();
            this.addEvents();
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            this.setBackFrame(this._index % 2 == 0 ? (1) : (2));
            return;
        }// end function

        public function get selected() : Boolean
        {
            return this._selected;
        }// end function

        public function set selected(param1:Boolean) : void
        {
            this._selected = param1;
            this.setSelect();
            return;
        }// end function

        public function get info()
        {
            return;
        }// end function

        public function set info(param1) : void
        {
            return;
        }// end function

        private function initItem() : void
        {
            if (this._className && this._className.length > 0)
            {
                this._content = ToolKit.getNew(this._className);
                this.addChild(this._content);
            }
            this.getComp();
            return;
        }// end function

        protected function getComp() : void
        {
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
                this.setTextColor(this.COLOR_SELECT);
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
                this.setTextColor(this.COLOR_NORMAL);
                if (this.mcBack)
                {
                    this.mcBack.gotoAndStop(this.index % 2 == 0 ? (1) : (2));
                }
            }
            return;
        }// end function

        protected function freshItem() : void
        {
            return;
        }// end function

        protected function setSelect() : void
        {
            if (this._selected)
            {
                this.setTextColor(this.COLOR_SELECT);
                if (this.mcBack)
                {
                    this.mcBack.gotoAndStop(4);
                }
            }
            else
            {
                this.setTextColor(this.COLOR_NORMAL);
                if (this.mcBack)
                {
                    this.mcBack.gotoAndStop(this.index % 2 == 0 ? (1) : (2));
                }
            }
            return;
        }// end function

        protected function setTextColor(param1:uint) : void
        {
            return;
        }// end function

        protected function setBackFrame(param1:int) : void
        {
            if (this.mcBack)
            {
                this.mcBack.gotoAndStop(param1);
            }
            return;
        }// end function

        public function clean() : void
        {
            return;
        }// end function

    }
}
