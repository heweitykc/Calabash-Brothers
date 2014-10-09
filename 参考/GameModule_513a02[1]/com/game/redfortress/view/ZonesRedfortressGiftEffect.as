package com.game.redfortress.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.greensock.*;
    import flash.display.*;

    public class ZonesRedfortressGiftEffect extends Component
    {
        private var vecTimeNumber:Vector.<MovieClip>;
        private var _className:String;
        private var _content:MovieClip;
        private var _count:int;
        private var _lineLite:TimelineLite;
        public static const ZONES_REDFORTRESS_GIFT_COUNT:String = "zones_redfortress_gift_count";

        public function ZonesRedfortressGiftEffect(param1 = null)
        {
            this.vecTimeNumber = new Vector.<MovieClip>;
            this._className = param1;
            this.initComp();
            return;
        }// end function

        private function initComp() : void
        {
            var _loc_2:* = null;
            this._content = MovieClip(ToolKit.getNew(this._className));
            this.addChild(this._content);
            var _loc_1:* = 0;
            while (_loc_1 < 3)
            {
                
                _loc_2 = MovieClip(this._content["num" + (_loc_1 + 1)]);
                this.vecTimeNumber[_loc_1] = _loc_2;
                _loc_2.gotoAndStop(1);
                _loc_1++;
            }
            return;
        }// end function

        private function setNum() : void
        {
            var _loc_1:* = this._count.toString();
            _loc_1 = _loc_1.length > 3 ? (_loc_1.substr(_loc_1.length - 3, 3)) : (_loc_1);
            while (_loc_1.length < 3)
            {
                
                _loc_1 = "0" + _loc_1;
            }
            var _loc_2:* = 0;
            while (_loc_2 < 3)
            {
                
                this.vecTimeNumber[_loc_2].gotoAndStop((int(_loc_1.charAt(_loc_1.length - _loc_2 - 1)) + 1));
                _loc_2++;
            }
            this.playEffect();
            return;
        }// end function

        private function prepPlay() : void
        {
            if (this._lineLite)
            {
                this._lineLite.kill();
                this._lineLite.stop();
                this._lineLite = null;
            }
            var _loc_1:* = 1.5;
            this.scaleY = 1.5;
            this.scaleX = _loc_1;
            this.alpha = 1;
            FrameworkGlobal.stage.addChild(this);
            this.move(FrameworkGlobal.stageW / 2, 150);
            return;
        }// end function

        private function playEffect() : void
        {
            this.prepPlay();
            this._lineLite = new TimelineLite();
            this._lineLite.append(new TweenLite(this, 0.2, {scaleX:1, scaleY:1}));
            this._lineLite.append(new TweenLite(this, 0.5, {}));
            this._lineLite.append(new TweenLite(this, 0.8, {y:100, alpha:0, onComplete:this.onComplete}));
            return;
        }// end function

        private function onComplete() : void
        {
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

        public function setCount(param1:int) : void
        {
            this.count = param1;
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            this.setNum();
            return;
        }// end function

    }
}
