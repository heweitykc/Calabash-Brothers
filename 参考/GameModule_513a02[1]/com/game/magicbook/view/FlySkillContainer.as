package com.game.magicbook.view
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import com.greensock.easing.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class FlySkillContainer extends BaseSprite
    {
        private var _arrow:DisplayObject;
        public var flyTime:Number = 0;
        private var currentSkillInfo:MagicBookSkillInfo;

        public function FlySkillContainer(param1:MagicBookSkillInfo)
        {
            if (this.currentSkillInfo != param1)
            {
                this.currentSkillInfo = param1;
            }
            mouseEnabled = false;
            mouseChildren = false;
            return;
        }// end function

        public function get arrow() : DisplayObject
        {
            return this._arrow;
        }// end function

        public function set arrow(param1:DisplayObject) : void
        {
            this._arrow = param1;
            return;
        }// end function

        public function fly(param1:Number, param2:Number, param3:Function = null, param4:Array = null, param5:int = 0) : void
        {
            var _loc_6:* = ToolKit.distance(param1, param2, x, y);
            this.flyTime = _loc_6 / this.currentSkillInfo.q_trajectory_speed;
            rotation = ToolKit.getAngle(x, y, param1, param2);
            if (this._arrow)
            {
                addChild(this._arrow);
                TweenLite.to(this, this.flyTime, {x:param1, y:param2, onComplete:param3, onCompleteParams:param4, ease:Linear.easeNone});
                TweenLite.delayedCall(this.flyTime, this.remove);
            }
            return;
        }// end function

        private function remove(event:Event = null) : void
        {
            removeFromParent(true);
            return;
        }// end function

        private function countDistine(param1:uint, param2:Number, param3:Number) : Point
        {
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            if (Math.abs(x - param2) > Math.abs(y - param3))
            {
                _loc_4 = x + (param2 > x ? (1) : (-1)) * param1;
                _loc_5 = (param3 * _loc_4 - param3 * x - y * _loc_4 + param2 * y) / (param2 - x);
            }
            else
            {
                _loc_5 = y + (param3 > y ? (1) : (-1)) * param1;
                _loc_4 = (param2 * _loc_5 - param2 * y - x * _loc_5 + param3 * x) / (param3 - y);
            }
            return new Point(_loc_4, _loc_5);
        }// end function

        public function flyByAngle(param1:Number, param2:uint, param3:Boolean = false, param4:Function = null, param5:Array = null) : void
        {
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            if (this._arrow)
            {
                this.flyTime = param2 / this.currentSkillInfo.q_trajectory_speed;
                addChild(this._arrow);
                _loc_6 = Math.PI * param1 / 180;
                _loc_7 = x + param2 * Math.cos(_loc_6);
                _loc_8 = y + param2 * Math.sin(_loc_6);
                TweenLite.to(this, this.flyTime, {x:_loc_7, y:_loc_8, onComplete:this.flyComplete, onCompleteParams:[param1, param4, param5, param3], ease:Linear.easeNone});
            }
            return;
        }// end function

        private function flyComplete(param1:Number, param2:Function, param3:Array, param4:Boolean) : void
        {
            var _loc_5:* = 0;
            var _loc_6:* = NaN;
            var _loc_7:* = NaN;
            var _loc_8:* = NaN;
            if (param4)
            {
                _loc_5 = 50;
                _loc_6 = Math.PI * param1 / 180;
                _loc_7 = x + _loc_5 * Math.cos(_loc_6);
                _loc_8 = y + _loc_5 * Math.sin(_loc_6);
                TweenLite.to(this, _loc_5 / this.currentSkillInfo.q_trajectory_speed, {alpha:0, x:_loc_7, y:_loc_8, onComplete:param2, onCompleteParams:param3});
                TweenLite.delayedCall(_loc_5 / this.currentSkillInfo.q_trajectory_speed, this.remove);
            }
            else
            {
                if (param2 != null)
                {
                    param2.apply(null, param3);
                }
                this.remove();
            }
            return;
        }// end function

    }
}
