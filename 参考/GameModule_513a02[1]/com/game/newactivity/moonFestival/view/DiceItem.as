package com.game.newactivity.moonFestival.view
{
    import com.f1.ui.*;
    import com.f1.vmc.*;
    import flash.display.*;
    import flash.utils.*;

    public class DiceItem extends Component
    {
        private var _isFour:Boolean;
        private var _effect:VMCView;
        private var _num:int;
        private var _delegate:MoonDiceView;
        private var _tempFour:Boolean;
        private var _complete:Boolean = false;
        private var effectid:int;

        public function DiceItem(param1 = null, param2:String = null)
        {
            super(param1, param2);
            return;
        }// end function

        public function get complete() : Boolean
        {
            return this._complete;
        }// end function

        public function set complete(param1:Boolean) : void
        {
            this._complete = param1;
            return;
        }// end function

        public function get tempFour() : Boolean
        {
            return this._tempFour;
        }// end function

        public function reset() : void
        {
            this._isFour = false;
            this._tempFour = false;
            clearTimeout(this.effectid);
            this.complete = true;
            if (this._effect)
            {
                this._effect.removeFromParent();
            }
            display.visible = true;
            return;
        }// end function

        public function get isFour() : Boolean
        {
            return this._isFour;
        }// end function

        public function set delegate(param1:MoonDiceView) : void
        {
            this._delegate = param1;
            return;
        }// end function

        public function showNum(param1:Boolean = false, param2:int = 1) : int
        {
            var _loc_3:* = Math.random() * 5 + 1;
            this._num = _loc_3;
            this._isFour = false;
            (display as MovieClip).gotoAndStop(this._num);
            if (param1)
            {
                this._delegate.singleEffectComplete(this._num, param2);
            }
            return this._num;
        }// end function

        public function animationShowNum(param1:int, param2:Boolean = false) : void
        {
            if (this._effect == null)
            {
                this._effect = new VMCView();
                this._effect.updatePose("90", true);
                this._effect.auto = true;
                this._effect.move(display.width * 0.5, display.height * 0.5);
            }
            this._tempFour = param2;
            display.visible = false;
            this._effect.loadRes("res/effect/moondice.png");
            this._effect.play();
            addChild(this._effect);
            this.complete = false;
            clearTimeout(this.effectid);
            this.effectid = setTimeout(this.__effectComplete, 1000, param1);
            return;
        }// end function

        private function __effectComplete(param1:int) : void
        {
            this.complete = true;
            this._effect.removeFromParent();
            display.visible = true;
            if (this.tempFour)
            {
                this.showFour(true, param1);
            }
            else
            {
                this.showNum(true, param1);
            }
            return;
        }// end function

        public function showFour(param1:Boolean = false, param2:int = 1) : void
        {
            this._isFour = true;
            (display as MovieClip).gotoAndStop(6);
            if (param1)
            {
                this._delegate.singleEffectComplete(6, param2);
            }
            return;
        }// end function

    }
}
