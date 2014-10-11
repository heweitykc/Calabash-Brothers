package com.game.redfortress.view
{
    import com.f1.ui.box.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.utils.*;
    import com.game.player.control.*;
    import com.game.role.*;
    import com.model.*;
    import com.staticdata.*;
    import com.util.*;
    import flash.display.*;
    import flash.geom.*;

    public class ZonesRedfortressPlayerDieRelive extends BaseBox
    {
        private var _downTime:DownTimer;
        private var _imgdown:ImgNumber;
        private var _wordImg:Bitmap;
        private var _backImg:Bitmap;

        public function ZonesRedfortressPlayerDieRelive(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._imgdown = new ImgNumber();
            this._backImg = new Bitmap(ToolKit.getNew("zones_redFortress_relive_back"));
            this._wordImg = new Bitmap(ToolKit.getNew("zones_redfortress_relive_word"));
            this._backImg.x = -80;
            this._backImg.y = -20;
            this._wordImg.x = 26;
            this.addChild(this._backImg);
            this.addChild(this._imgdown);
            this.addChild(this._wordImg);
            this._downTime = new DownTimer();
            this._downTime.callBack = this.calldownBack;
            return;
        }// end function

        private function calldownBack(param1:int) : void
        {
            var _loc_2:* = param1 / 1000;
            this._imgdown.setNumber(_loc_2.toString(), 40);
            if (_loc_2 <= 0)
            {
                this.callend();
            }
            return;
        }// end function

        private function callend() : void
        {
            this.close();
            PlayerControl.getInstance().reqRevive(AutoReviveType.RETURN_REVIVE);
            return;
        }// end function

        public function startDelayRelive(param1:int) : void
        {
            this._downTime.count = param1 * 1000;
            if (param1 > 0)
            {
                this.open();
            }
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            var _loc_1:* = RoleList.getInstance().player as Role;
            var _loc_2:* = _loc_1.localToGlobal(new Point(-90, -178));
            this.move(_loc_2.x, _loc_2.y);
            return;
        }// end function

    }
}
