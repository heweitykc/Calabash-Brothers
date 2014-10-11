package com.view.ui
{
    import com.f1.*;
    import com.f1.ui.btn.*;
    import flash.display.*;
    import flash.events.*;

    public class TabContainer extends BaseEventDispatcher
    {
        private var _length:uint = 0;
        private var btnAry:Array;
        private var _index:int = -1;
        private var viewAry:Array;
        public var internalX:int = 1;
        public var internalY:int = 1;
        public var obj:Object;
        public var horizontal:Boolean = true;

        public function TabContainer()
        {
            this.btnAry = [];
            this.viewAry = [];
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set selected(param1:int) : void
        {
            if (this.btnAry.length > param1)
            {
                this.select(param1);
            }
            else
            {
                throw new Error("TabContainer 选择越界");
            }
            return;
        }// end function

        public function add(param1:BaseButton, param2:DisplayObject = null) : void
        {
            var _loc_3:* = this;
            var _loc_4:* = this._length + 1;
            _loc_3._length = _loc_4;
            if (param1)
            {
                this.btnAry.push(param1);
                param1.addEvtListener(MouseEvent.CLICK, this.__clickTabBtn);
                this.viewAry.push(param2);
            }
            return;
        }// end function

        private function __clickTabBtn(event:MouseEvent) : void
        {
            var _loc_2:* = this.btnAry.indexOf(event.target);
            this.selected = _loc_2;
            return;
        }// end function

        private function select(param1:int) : void
        {
            if (this._index == param1)
            {
                this.btnAry[param1].selected = true;
                return;
            }
            this.obj = this.btnAry[param1];
            this._index = param1;
            var _loc_2:* = 0;
            while (_loc_2 < this.btnAry.length)
            {
                
                if (this._index == _loc_2)
                {
                    this.btnAry[_loc_2].selected = true;
                    if (this.viewAry[_loc_2])
                    {
                        this.viewAry[_loc_2].visible = true;
                    }
                    dispatchEvt(new Event(Event.CHANGE));
                }
                else
                {
                    this.btnAry[_loc_2].selected = false;
                    if (this.viewAry[_loc_2])
                    {
                        this.viewAry[_loc_2].visible = false;
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        public function get length() : uint
        {
            return this._length;
        }// end function

        public function splice(param1:BaseButton) : void
        {
            var _loc_3:* = 0;
            var _loc_2:* = this.btnAry.indexOf(param1);
            if (_loc_2 != -1)
            {
                _loc_3 = _loc_2 + 1;
                while (_loc_3 < this.btnAry.length)
                {
                    
                    this.btnAry[_loc_3].x = this.btnAry[(_loc_3 - 1)].x;
                    this.btnAry[_loc_3].y = this.btnAry[(_loc_3 - 1)].y;
                    _loc_3++;
                }
                this.btnAry.splice(_loc_2, 1);
                this.viewAry.splice(_loc_2, 1);
            }
            return;
        }// end function

        public function insertTo(param1:BaseButton, param2:DisplayObject = null, param3:int = 0) : void
        {
            if (param1 == null)
            {
                return;
            }
            if (this.btnAry.indexOf(param1) != -1)
            {
                return;
            }
            if (this.btnAry.length < param3)
            {
                param3 = this.btnAry.length;
            }
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (this.btnAry.length > 0)
            {
                _loc_4 = this.btnAry[0].x;
                _loc_5 = this.btnAry[0].y;
            }
            this.btnAry.splice(param3, 0, param1);
            this.viewAry.splice(param3, 0, param2);
            param1.addEvtListener(MouseEvent.CLICK, this.__clickTabBtn);
            var _loc_6:* = 0;
            var _loc_7:* = 0;
            var _loc_8:* = 0;
            while (_loc_8 < this.btnAry.length)
            {
                
                if (this.horizontal)
                {
                    _loc_6 = _loc_6 + ((this.btnAry[_loc_8] as BaseButton).width + this.internalX);
                    if (_loc_8 >= param3)
                    {
                        this.btnAry[_loc_8].x = _loc_6;
                        this.btnAry[_loc_8].y = _loc_5;
                    }
                }
                else
                {
                    _loc_7 = _loc_7 + ((this.btnAry[_loc_8] as BaseButton).height + this.internalY);
                    if (_loc_8 >= param3)
                    {
                        this.btnAry[_loc_8].y = _loc_7;
                        this.btnAry[_loc_8].x = _loc_4;
                    }
                }
                _loc_8++;
            }
            return;
        }// end function

    }
}
