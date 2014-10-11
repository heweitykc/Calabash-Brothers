package com.cfg.obj
{
    import com.cfg.vo.*;
    import com.f1.manager.*;

    public class QMusicCfgObj extends Object
    {
        private static var _instance:QMusicCfgObj;
        private static var _map:Object;

        public function QMusicCfgObj()
        {
            _map = CfgManager.getInstance().getMap("q_music");
            return;
        }// end function

        public function getMusicByKey(param1:String) : QMusic
        {
            var _loc_2:* = new QMusic();
            _loc_2.parse(_map[param1]);
            return _loc_2;
        }// end function

        public function getMusicCfg() : Object
        {
            return _map;
        }// end function

        public static function getInstance() : QMusicCfgObj
        {
            if (!_instance)
            {
                _instance = new QMusicCfgObj;
            }
            return _instance;
        }// end function

    }
}
