package com.game.greedisland.control
{
    import com.*;
    import com.game.greedisland.protocol.*;
    import com.game.greedisland.view.*;
    import com.game.zones.control.*;
    import com.staticdata.*;

    public class IslandControl extends Object
    {
        private var _islandBox:IslandBox;
        private var _islandBag:IslandBag;
        private var _islandBoxTips:IslandBoxTips;
        private var _islandOverPanel:IslandOverPanel;
        private var _islandCopySurePanel:IslandCopySurePanel;
        private var _protocol:IslandProtocol;
        private static var _instance:IslandControl;
        public static const SAFE_TIME:int = 10;

        public function IslandControl()
        {
            this._protocol = new IslandProtocol();
            return;
        }// end function

        public function get islandBox() : IslandBox
        {
            return this._islandBox;
        }// end function

        public function openIslandBox() : void
        {
            if (!this._islandBox)
            {
                this._islandBox = new IslandBox();
                Global.popManager.addPop(this._islandBox);
            }
            this._islandBox.openOrClose();
            return;
        }// end function

        public function openIslandBag(param1:int) : void
        {
            if (!this._islandBag)
            {
                this._islandBag = new IslandBag();
                Global.popManager.addPop(this._islandBag);
            }
            this._islandBag.type = param1;
            this._islandBag.open();
            return;
        }// end function

        public function openIslandBoxTips() : void
        {
            if (!this._islandBoxTips)
            {
                this._islandBoxTips = new IslandBoxTips();
                Global.popManager.addPop(this._islandBoxTips);
            }
            this._islandBoxTips.openOrClose();
            return;
        }// end function

        public function openIslandOverPanel() : void
        {
            if (!this._islandOverPanel)
            {
                this._islandOverPanel = new IslandOverPanel();
                Global.popManager.addPop(this._islandOverPanel);
            }
            this._islandOverPanel.openOrClose();
            return;
        }// end function

        public function openIslandCopySurePanel() : void
        {
            if (!this._islandCopySurePanel)
            {
                this._islandCopySurePanel = new IslandCopySurePanel();
                Global.popManager.addPop(this._islandCopySurePanel, false, false, true, true, false, true);
            }
            this._islandCopySurePanel.openOrClose();
            return;
        }// end function

        public function setStartCue(param1:int) : void
        {
            ZonesControl.getInstance().zonesDownTime.updateDownTime(1, 0, param1);
            return;
        }// end function

        public function reqEnterIslandCopy(param1:int = 0, param2:int = 9001) : void
        {
            ZonesControl.getInstance().reqZoneTeamEnterToGame(0, Params.ISLAND_COPY_ID);
            return;
        }// end function

        public function reqGoldCombo() : void
        {
            this._protocol.reqIslandGoldCombo();
            return;
        }// end function

        public static function getInstance() : IslandControl
        {
            if (_instance == null)
            {
                _instance = new IslandControl;
            }
            return _instance;
        }// end function

    }
}
