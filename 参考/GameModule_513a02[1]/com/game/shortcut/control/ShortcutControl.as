package com.game.shortcut.control
{
    import __AS3__.vec.*;
    import com.game.operationpanel.control.*;
    import com.game.shortcut.*;
    import com.game.shortcut.message.*;
    import com.game.shortcut.model.*;
    import com.game.utils.*;

    public class ShortcutControl extends Object
    {
        private var _protocol:ShortcutProtocol;
        private var _model:ShortcutModel;
        private static var instance:ShortcutControl;

        public function ShortcutControl()
        {
            this._protocol = new ShortcutProtocol();
            this._model = new ShortcutModel();
            return;
        }// end function

        public function addShortCutHandle(param1:int, param2:long, param3:int, param4:int) : void
        {
            this._protocol.addShortCutHandle(param1, param2, param3, param4);
            return;
        }// end function

        public function removeShortCutHandle(param1:long) : void
        {
            this._protocol.removeShortCutHandle(param1);
            return;
        }// end function

        public function moveShortCutHandle(param1:int, param2:long) : void
        {
            this._protocol.moveShortCutHandle(param1, param2);
            return;
        }// end function

        public function shortCutAddHandle(param1:ShortCutAddMessage) : void
        {
            this._model.addShortCut(param1.shortcut);
            OperationPanelControl.getInstance().shortCutAdd(param1.shortcut);
            return;
        }// end function

        public function shortCutRemoveHandle(param1:ShortCutRemoveMessage) : void
        {
            this._model.removeShortCut(param1.shortcutGrid);
            OperationPanelControl.getInstance().shortCutRemove(param1.shortcutGrid);
            return;
        }// end function

        public function shortcutInfosHandler(param1:ShortCutInfosMessage) : void
        {
            this._model.shortcutInfos = param1.shortcuts;
            OperationPanelControl.getInstance().shortcutInfos();
            return;
        }// end function

        public function getShortcutInfos() : Vector.<ShortCutInfo>
        {
            return this._model.shortcutInfos;
        }// end function

        public static function getInstance() : ShortcutControl
        {
            if (instance == null)
            {
                instance = new ShortcutControl;
            }
            return instance;
        }// end function

    }
}
