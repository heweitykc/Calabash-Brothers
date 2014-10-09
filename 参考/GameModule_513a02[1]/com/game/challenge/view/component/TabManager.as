package com.game.challenge.view.component
{
    import com.f1.*;
    import com.f1.ui.btn.*;
    import flash.display.*;
    import flash.events.*;

    public class TabManager extends BaseSprite
    {
        private var _length:uint = 0;
        private var btnAry:Array;
        private var _index:int = -1;
        private var viewAry:Array;
        private var _content:Sprite;
        public var obj:Object;

        public function TabManager(param1:BaseSprite = null)
        {
            this.btnAry = [];
            this.viewAry = [];
            if (param1)
            {
                this._content = param1;
            }
            else
            {
                this._content = this;
            }
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

        public function add(param1:BaseButton, param2 = null, param3 = null) : void
        {
            var _loc_4:* = this;
            var _loc_5:* = this._length + 1;
            _loc_4._length = _loc_5;
            if (param1)
            {
                this.btnAry.push(param1);
                param1.addEvtListener(MouseEvent.CLICK, this.__clickTabBtn);
                if (param2 != null)
                {
                    if (param2 is Class)
                    {
                        if (param3)
                        {
                            this.viewAry.push(new param2(param3));
                        }
                        else
                        {
                            this.viewAry.push(new param2);
                        }
                    }
                    else if (param2 is DisplayObject)
                    {
                        this.viewAry.push(param2);
                    }
                    else
                    {
                        this.viewAry.push(null);
                    }
                }
                else
                {
                    this.viewAry.push(null);
                }
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
                        this._content.addChild(this.viewAry[_loc_2]);
                    }
                    dispatchEvt(new Event(Event.CHANGE));
                }
                else
                {
                    this.btnAry[_loc_2].selected = false;
                    if (this.viewAry[_loc_2] && this.viewAry[_loc_2].parent)
                    {
                        this.viewAry[_loc_2].parent.removeChild(this.viewAry[_loc_2]);
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

        override public function finalize() : void
        {
            var _loc_1:* = this.btnAry.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                if (this.btnAry[_loc_2])
                {
                    this.btnAry[_loc_2].removeEvtListener(MouseEvent.CLICK, this.__clickTabBtn);
                }
                _loc_2++;
            }
            super.finalize();
            return;
        }// end function

    }
}
