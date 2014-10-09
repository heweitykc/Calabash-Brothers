package com.game.map.view.scrollcue
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.getItem.view.*;
    import com.model.vo.*;

    public class ScrollCue extends BaseSprite
    {
        private var _isTween:Boolean;
        private var _list:Array;

        public function ScrollCue()
        {
            this._list = [];
            return;
        }// end function

        public function addChest(param1:PropInfo) : void
        {
            this._list.push(param1);
            if (!this._isTween)
            {
                this._isTween = true;
                this.next();
            }
            return;
        }// end function

        public function next() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = this._list.shift();
            if (_loc_1 != null)
            {
                _loc_2 = ObjectPool.CheckOut(ChestGetTip) as ChestGetTip;
                _loc_2.scrollCue = this;
                _loc_2.info = _loc_1;
            }
            else
            {
                this._isTween = false;
            }
            return;
        }// end function

    }
}
