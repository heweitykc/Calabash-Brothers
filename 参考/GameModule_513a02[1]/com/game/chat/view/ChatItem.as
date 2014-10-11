package com.game.chat.view
{
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;
    import com.game.role.util.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ChatItem extends BaseButton implements IItem
    {
        private var _label:String;
        private var _levelTxt:TextField;
        private var _bg:MovieClip;
        private var _index:int;

        public function ChatItem()
        {
            super("chatItemName", true);
            this._levelTxt = getDisplayChildByName("txt_level");
            this._bg = getDisplayChildByName("bg");
            addEvtListener(MouseEvent.ROLL_OVER, this.__over);
            addEvtListener(MouseEvent.ROLL_OUT, this.__outItem);
            return;
        }// end function

        override public function get key()
        {
            return _obj.label;
        }// end function

        override public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            super.obj = param1;
            this.index = obj.index;
            this.setText(obj.name);
            this.setLevel(obj.level);
            return;
        }// end function

        override public function setWidth(param1:Number) : void
        {
            display.width = param1;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            if (this._bg)
            {
                this._bg.gotoAndStop(this.index % 2 == 0 ? (1) : (2));
            }
            return;
        }// end function

        override public function setText(param1:String, param2:Boolean = false) : void
        {
            super.setText(param1);
            return;
        }// end function

        override public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            super.setSelected(param1, param2);
            if (param1)
            {
                this._bg.gotoAndStop(4);
            }
            else if (this._bg)
            {
                this._bg.gotoAndStop(this.index % 2 == 0 ? (1) : (2));
            }
            return;
        }// end function

        public function setItemSelected(param1:Boolean) : void
        {
            if (param1)
            {
                this._bg.gotoAndStop(4);
            }
            else if (this._bg)
            {
                this._bg.gotoAndStop(this.index % 2 == 0 ? (1) : (2));
            }
            return;
        }// end function

        private function __over(event:MouseEvent) : void
        {
            if (!_selected)
            {
                this._bg.gotoAndStop(3);
            }
            return;
        }// end function

        private function __outItem(event:MouseEvent) : void
        {
            if (!_selected)
            {
                if (this._bg)
                {
                    this._bg.gotoAndStop(this.index % 2 == 0 ? (1) : (2));
                }
            }
            return;
        }// end function

        public function setLevel(param1:String) : void
        {
            if (this._levelTxt)
            {
                this._levelTxt.text = RoleLevelUtil.getMasterLevel(int(param1));
            }
            return;
        }// end function

    }
}
