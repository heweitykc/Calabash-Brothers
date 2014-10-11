package com.game.dragonking.control
{
    import com.f1.vmc.*;
    import com.game.dragonking.*;
    import com.game.map.control.*;
    import com.game.role.*;
    import com.greensock.*;
    import com.model.*;

    public class FallDownControl extends Object implements IPhaseControl
    {
        private var _fallview:VMCView;
        private var _showView:VMCView;

        public function FallDownControl()
        {
            return;
        }// end function

        public function start() : void
        {
            MapControl.getInstance().setPlayerOperatable(false);
            RoleList.getInstance().player.visible = false;
            TweenLite.delayedCall(2.96, this.falldown);
            TweenLite.delayedCall(3.26, this.fallComplete);
            return;
        }// end function

        private function falldown() : void
        {
            TweenLite.killDelayedCallsTo(this.falldown);
            var _loc_1:* = RoleList.getInstance().player as Player;
            this._fallview = new VMCView();
            this._fallview.auto = true;
            this._fallview.updatePose("90", false);
            this._fallview.loadRes("res/effect/falldown.png");
            this._fallview.move(_loc_1._x, _loc_1._y);
            MapControl.getInstance().currentGameScene.topLayer.addChild(this._fallview);
            return;
        }// end function

        private function jj() : void
        {
            return;
        }// end function

        private function fallComplete() : void
        {
            TweenLite.killDelayedCallsTo(this.fallComplete);
            RoleList.getInstance().player.visible = true;
            this.end();
            return;
        }// end function

        public function end() : void
        {
            this._fallview.finalize();
            DragonKingController.getInstance().nextRound();
            return;
        }// end function

    }
}
