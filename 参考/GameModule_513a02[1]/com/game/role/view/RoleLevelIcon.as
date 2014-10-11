package com.game.role.view
{
    import com.f1.*;
    import com.f1.vmc.*;
    import com.game.role.util.*;
    import com.staticdata.*;
    import flash.text.*;

    public class RoleLevelIcon extends BaseSprite
    {
        private var _text:TextField;
        private var _level:int;
        private var _preLv:String;
        private var _afterLv:String;
        private var _effect:VMCView;

        public function RoleLevelIcon(param1 = "vip_high_9")
        {
            this.initBack(param1);
            this.initIcon();
            return;
        }// end function

        private function initBack(param1) : void
        {
            return;
        }// end function

        private function initIcon() : void
        {
            this.mouseEnabled = false;
            this._text = new TextField();
            this._text.height = 22;
            this._text.width = 50;
            this._text.mouseEnabled = false;
            this._text.textColor = 65280;
            this.addChild(this._text);
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            this.showLevel();
            return;
        }// end function

        private function showLevel() : void
        {
            if (this.level <= 0)
            {
                this._text.text = "";
                this.hideEffect();
                return;
            }
            if (RoleLevelUtil.isMasterLevel(this.level))
            {
                this._text.x = 30;
                if (this.afterLv)
                {
                    this._text.text = String(this.level - Params.ROLE_MAX_LEVEL) + this.afterLv;
                }
                else
                {
                    this._text.text = String(this.level - Params.ROLE_MAX_LEVEL);
                }
                this.showEffect();
            }
            else
            {
                this._text.x = 18;
                if (this.preLv)
                {
                    this._text.text = this.preLv + this.level.toString();
                }
                else
                {
                    this._text.text = this.level.toString();
                }
                this.hideEffect();
            }
            return;
        }// end function

        private function hideEffect() : void
        {
            if (this._effect)
            {
                this._effect.stop();
                this._effect.finalize();
                this._effect = null;
            }
            return;
        }// end function

        private function showEffect() : void
        {
            if (!this._effect)
            {
                this._effect = new VMCView();
                this._effect.move(18, 8);
                this._effect.auto = true;
                this._effect.updatePose("90", true);
                this.addChild(this._effect);
            }
            this._effect.loadRes("res/effect/bigmaster/master_sign_effect.png", null, true);
            return;
        }// end function

        public function set textColor(param1:uint) : void
        {
            this._text.textColor = param1;
            return;
        }// end function

        public function get textColor() : uint
        {
            return this._text.textColor;
        }// end function

        public function get preLv() : String
        {
            return this._preLv;
        }// end function

        public function set preLv(param1:String) : void
        {
            this._preLv = param1;
            return;
        }// end function

        public function get afterLv() : String
        {
            return this._afterLv;
        }// end function

        public function set afterLv(param1:String) : void
        {
            this._afterLv = param1;
            return;
        }// end function

    }
}
