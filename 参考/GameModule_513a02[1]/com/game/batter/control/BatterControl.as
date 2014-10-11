package com.game.batter.control
{
    import com.game.batter.message.*;
    import com.game.batter.model.*;
    import com.game.batter.view.*;

    public class BatterControl extends Object
    {
        private var _viewBatterKill:BatterMonsterKillView;
        private var _model:BatterModel;
        private static var _instance:BatterControl;

        public function BatterControl()
        {
            this._model = new BatterModel();
            return;
        }// end function

        public function momentKillToClient(param1:ResMomentKillToClientMessage) : void
        {
            return;
        }// end function

        public function monsterBatterToClient(param1:ResMonsterBatterToClientMessage) : void
        {
            this.openView();
            this._viewBatterKill.setKillsInfo(param1.lev, param1.num, param1.type, param1.countdowntime);
            return;
        }// end function

        public function openView() : void
        {
            if (!this._viewBatterKill)
            {
                this._viewBatterKill = new BatterMonsterKillView();
            }
            this._viewBatterKill.openMe();
            return;
        }// end function

        public function closeViewBatterKill() : void
        {
            if (this._viewBatterKill)
            {
                this._viewBatterKill.closeMe();
            }
            return;
        }// end function

        public static function getInstance() : BatterControl
        {
            if (!_instance)
            {
                _instance = new BatterControl;
            }
            return _instance;
        }// end function

    }
}
