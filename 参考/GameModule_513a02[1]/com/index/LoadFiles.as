package com.index
{
    import com.f1.manager.resource.*;

    public class LoadFiles extends Object
    {
        private static var instance:LoadFiles;

        public function LoadFiles()
        {
            return;
        }// end function

        public function startLoad(param1:Function, param2:Function) : void
        {
            VResManager.load("index_files.xml", this.__xmlComplete, [param1, param2]);
            return;
        }// end function

        private function __xmlComplete(param1, param2:Function, param3:Function) : void
        {
            var _loc_6:* = null;
            var _loc_7:* = null;
            var _loc_4:* = XML(param1);
            var _loc_5:* = [];
            for each (_loc_7 in _loc_4.res)
            {
                
                _loc_6 = String(_loc_7.@url[0]);
                _loc_5.push(_loc_6);
            }
            VResManager.loadGroup(_loc_5, null, null, null, param3, param2, null, false, false, true);
            return;
        }// end function

        private function loadOk() : void
        {
            return;
        }// end function

        public static function getInstance() : LoadFiles
        {
            if (instance == null)
            {
                instance = new LoadFiles;
            }
            return instance;
        }// end function

    }
}
