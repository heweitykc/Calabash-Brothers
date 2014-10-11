package com.game.login.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.manager.resource.*;
    import com.f1.utils.*;
    import com.game.clickstream.*;
    import com.game.login.protocol.*;
    import com.game.map.model.*;
    import com.model.vo.*;
    import com.staticdata.*;

    public class LoginControl extends Object
    {
        private var _protocol:LoginProtocol;
        private static var instance:LoginControl;

        public function LoginControl()
        {
            this._protocol = new LoginProtocol();
            return;
        }// end function

        public function loginFinish() : void
        {
            Log.log("LoginControl.loginFinish === begin, mapId: " + RegistControl.getInstance().loginSuccessHandlerMsg.mapId);
            ClickStream.add(ClickStreamId.LOAD_MAP_RESOURCE_START);
            MapObj.getInstance().mapID = RegistControl.getInstance().loginSuccessHandlerMsg.mapId;
            var _loc_1:* = MapCfgObj.getInstance().getMap(MapObj.getInstance().mapID);
            var _loc_2:* = Params.MAP_PATH + _loc_1.url + ".bin";
            var _loc_3:* = Params.MAP_MAPRES_PATH + "ground/" + _loc_1.url + "/small.jpg";
            VResManager.loadGroup([_loc_2, _loc_3], null, null, null, Global.popManager.showLoadingBox(true, 3, 1), this.loadMapComplete, null, true, false, true, 0, FrameworkGlobal.LOAD_PRELOAD_UI);
            return;
        }// end function

        private function loadMapComplete() : void
        {
            ClickStream.add(ClickStreamId.LOAD_MAP_RESOURCE_OK);
            Global.popManager.closeLoadingBox();
            BasicGlobal.gameModule.initGame();
            return;
        }// end function

        public function loadFinish() : void
        {
            this._protocol.loadFinish();
            return;
        }// end function

        public static function getInstance() : LoginControl
        {
            if (instance == null)
            {
                instance = new LoginControl;
            }
            return instance;
        }// end function

    }
}
