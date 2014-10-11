package com.cfg.obj
{
    import com.f1.manager.*;

    public class MusicCfgObj extends Object
    {
        private var _map:Object;
        private static var instance:MusicCfgObj;

        public function MusicCfgObj()
        {
            this._map = CfgManager.getInstance().getMap("q_mp3");
            return;
        }// end function

        public function getMusicById(param1:String) : Object
        {
            return this._map[param1];
        }// end function

        public function getMusicMap() : Object
        {
            return this._map;
        }// end function

        public static function getInstance() : MusicCfgObj
        {
            if (instance == null)
            {
                instance = new MusicCfgObj;
            }
            return instance;
        }// end function

    }
}
