package com.game.shortcut.model
{
    import __AS3__.vec.*;
    import com.game.shortcut.bean.*;

    public class ShortcutModel extends Object
    {
        private var vecShortcutInfos:Vector.<ShortCutInfo>;
        private static var _instance:ShortcutModel;

        public function ShortcutModel()
        {
            this.vecShortcutInfos = new Vector.<ShortCutInfo>(9, true);
            return;
        }// end function

        public function set shortcutInfos(param1:Vector.<ShortCutInfo>) : void
        {
            var _loc_2:* = 0;
            while (_loc_2 < param1.length)
            {
                
                if (param1.length > _loc_2)
                {
                    this.vecShortcutInfos[(param1[_loc_2].shortcutGrid - 1)] = param1[_loc_2];
                }
                _loc_2++;
            }
            return;
        }// end function

        public function get shortcutInfos() : Vector.<ShortCutInfo>
        {
            return this.vecShortcutInfos;
        }// end function

        public function addShortCut(param1:ShortCutInfo) : void
        {
            this.vecShortcutInfos[(param1.shortcutGrid - 1)] = param1;
            return;
        }// end function

        public function removeShortCut(param1:int) : void
        {
            this.vecShortcutInfos[(param1 - 1)] = null;
            return;
        }// end function

        public static function getInstance() : ShortcutModel
        {
            if (!_instance)
            {
                _instance = new ShortcutModel;
            }
            return _instance;
        }// end function

    }
}
