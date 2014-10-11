package com.game.operationpanel.view
{
    import com.f1.utils.*;
    import com.game.backpack.view.itemrenderers.*;
    import com.view.*;
    import flash.display.*;
    import flash.text.*;

    public class ItemShortcutBox extends Itemrenderer
    {
        protected var _isNum:Boolean;
        private var numArea:MovieClip;

        public function ItemShortcutBox(param1:String = "backpackbox_bg")
        {
            super(param1);
            this.numArea = ToolKit.getNew("skillGridNum");
            this.setImageSize(48, 48);
            _countTxt.y = 40;
            setWH(58, 58);
            lockOffsetY = -8;
            lockOffsetX = 2;
            return;
        }// end function

        public function get isNum() : Boolean
        {
            return this._isNum;
        }// end function

        public function set isNum(param1:Boolean) : void
        {
            this._isNum = param1;
            if (param1)
            {
                this.addChild(this.numArea);
                this.numArea.x = -2;
                this.numArea.y = -2;
            }
            else if (this.numArea.parent)
            {
                this.numArea.parent.removeChild(this.numArea);
            }
            return;
        }// end function

        override public function setCD(param1:int, param2:int) : void
        {
            if (_cdMask == null)
            {
                _cdMask = new CDMask(_w - 6, _h - 6, true);
                _cdMask.mouseEnabled = false;
            }
            if (_cdMask.parent == null)
            {
                _cdMask.x = 1;
                _cdMask.y = 1;
                addChild(_cdMask);
            }
            _cdMask.setCD(param1, param2);
            return;
        }// end function

        public function setNum(param1:String) : void
        {
            TextField(this.numArea["txt_num"]).text = param1;
            return;
        }// end function

    }
}
