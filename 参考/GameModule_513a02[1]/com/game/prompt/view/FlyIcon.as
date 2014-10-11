package com.game.prompt.view
{
    import com.f1.vmc.*;
    import com.view.icon.*;

    public class FlyIcon extends IconBase
    {
        protected var _effect:VMCView;

        public function FlyIcon(param1 = "backpackbox_bg")
        {
            this._effect = new VMCView();
            super(param1);
            this._effect = new VMCView();
            this._effect.scale = 0.6;
            this._effect.auto = true;
            this._effect.updatePose("90", true);
            this._effect.move(64 / 2, 64 / 2);
            addChild(this._effect);
            return;
        }// end function

        override public function setInfo(param1:Object, param2:Boolean = false) : void
        {
            if (param1 && param1.hasOwnProperty("effectUrl") && param1.effectUrl != null)
            {
                this._effect.loadRes(param1.effectUrl);
                return;
            }
            if (param1 && param1.hasOwnProperty("url"))
            {
                _image.load(param1.url, null, null, null, true);
            }
            return;
        }// end function

        override public function finalize() : void
        {
            this._effect.finalize();
            super.finalize();
            return;
        }// end function

    }
}
