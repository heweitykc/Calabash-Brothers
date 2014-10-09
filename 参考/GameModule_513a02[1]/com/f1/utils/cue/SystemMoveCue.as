package com.f1.utils.cue
{
    import com.f1.utils.*;
    import com.greensock.*;
    import flash.display.*;

    public class SystemMoveCue extends Object
    {
        protected var _items:Array;
        protected const MAX_ITEM_LENGTH:uint = 5;
        protected var isAutoDisAppear:Boolean;

        public function SystemMoveCue()
        {
            this._items = [];
            return;
        }// end function

        public function add(param1:DisplayObject) : void
        {
            this.killTween();
            this.resetPosition();
            this._items.unshift(param1);
            param1.y = this.MAX_ITEM_LENGTH * param1.height;
            this.startEffect();
            TweenLite.killDelayedCallsTo(this.removeItem);
            TweenLite.delayedCall(2, this.removeItem);
            return;
        }// end function

        protected function removeItem() : void
        {
            var complete:Function;
            var mc:DisplayObject;
            complete = function () : void
            {
                var _loc_1:* = null;
                while (_items.length > 0)
                {
                    
                    _loc_1 = _items.pop();
                    if (_loc_1 && _loc_1.parent)
                    {
                        _loc_1.parent.removeChild(_loc_1);
                        ObjectPool.CheckIn(_loc_1);
                    }
                }
                return;
            }// end function
            ;
            var length:* = this._items.length;
            var tempI:int;
            while (tempI < length)
            {
                
                mc = this._items[tempI];
                if (tempI == (length - 1))
                {
                    TweenLite.to(mc, 0.5, {alpha:0, onComplete:complete});
                }
                else
                {
                    TweenLite.to(mc, 0.5, {alpha:0});
                }
                tempI = (tempI + 1);
            }
            return;
        }// end function

        protected function killTween() : void
        {
            var _loc_1:* = this._items.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                TweenLite.killTweensOf(this._items[_loc_2], true);
                _loc_2++;
            }
            return;
        }// end function

        protected function startEffect() : void
        {
            var _loc_1:* = null;
            while (this._items.length > this.MAX_ITEM_LENGTH)
            {
                
                _loc_1 = this._items.pop();
            }
            if (_loc_1)
            {
                TweenLite.to(_loc_1, 0.5, {alpha:0, onComplete:this.onDisappear, onCompleteParams:[_loc_1]});
            }
            else
            {
                this.onDisappear();
            }
            return;
        }// end function

        protected function onDisappear(param1:DisplayObject = null) : void
        {
            if (param1)
            {
                param1.parent.removeChild(param1);
                ObjectPool.CheckIn(param1);
            }
            var _loc_2:* = 0;
            while (_loc_2 < this._items.length)
            {
                
                TweenLite.to(this._items[_loc_2], 0.3, {y:(this.MAX_ITEM_LENGTH - _loc_2 - 1) * this._items[_loc_2].height});
                _loc_2++;
            }
            return;
        }// end function

        protected function resetPosition() : void
        {
            var _loc_1:* = this._items.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._items[_loc_2].y = (this.MAX_ITEM_LENGTH - _loc_2 - 1) * this._items[_loc_2].height;
                _loc_2++;
            }
            return;
        }// end function

    }
}
