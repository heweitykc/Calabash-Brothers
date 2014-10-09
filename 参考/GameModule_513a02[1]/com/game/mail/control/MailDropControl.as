package com.game.mail.control
{
    import __AS3__.vec.*;
    import com.game.prompt.utils.*;
    import com.greensock.*;
    import flash.geom.*;

    public class MailDropControl extends Object
    {
        private var _items:Array;
        private var isstart:Boolean;
        private static var _inst:MailDropControl;

        public function MailDropControl()
        {
            this._items = [];
            return;
        }// end function

        public function addItems(param1:Vector.<int>) : void
        {
            if (!this.isstart)
            {
                this.isstart = true;
                this._items.push(param1);
                this.startToTween();
            }
            else
            {
                this._items.push(param1);
                TweenLite.delayedCall(0.2 * this._items.length, this.startToTween);
            }
            return;
        }// end function

        public function startToTween() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = this._items.pop();
            if (_loc_1)
            {
                _loc_2 = 0;
                while (_loc_2 < _loc_1.length)
                {
                    
                    if (_loc_1[_loc_2] < 0)
                    {
                    }
                    else
                    {
                        _loc_3 = new Point(MailController.getInstance().onekeyDropPoint.x + (_loc_2 - _loc_1.length / 2) * 44, MailController.getInstance().onekeyDropPoint.y);
                        ItemGetAnim.doFlyToBackPack(_loc_1[_loc_2], _loc_3);
                    }
                    _loc_2++;
                }
            }
            else
            {
                this.isstart = false;
            }
            return;
        }// end function

        public static function getInstance() : MailDropControl
        {
            var _loc_1:* = new MailDropControl;
            _inst = new MailDropControl;
            return _inst || _loc_1;
        }// end function

    }
}
