package com.game.player.control
{
    import com.*;
    import com.f1.*;
    import com.game.clickstream.*;
    import com.game.map.control.*;
    import com.game.map.view.topbtnspanel.*;
    import com.game.player.message.*;
    import com.game.player.protocol.*;
    import com.game.player.view.*;
    import com.game.task.*;
    import com.game.task.events.*;
    import com.game.task.model.*;
    import com.model.*;
    import flash.events.*;

    public class ChangeJobControl extends Object
    {
        private var _changeJobBox:ChangeJobBox;
        private var _changeJobSurePanel:ChangeJobSurePanel;
        private var _hasChange1:Boolean = false;
        private var _hasChange2:Boolean = false;
        private var _hasChange3:Boolean = false;
        private var _activeCount:int = 0;
        private var _prob:int = 0;
        private var _isActiviteBack:Boolean = false;
        private var _protocol:ChangeJobProtocol;
        private static var _instance:ChangeJobControl;

        public function ChangeJobControl()
        {
            this._protocol = new ChangeJobProtocol();
            FrameworkGlobal.addMsgListen(TaskEvent.DELETE_COMPLETE_TASK, this.updataBtn);
            TaskGlobal.myEvt.addEventListener(TaskEvent.GET_NEW_TASK, this.getNewTask);
            return;
        }// end function

        public function get changeJobBox() : ChangeJobBox
        {
            return this._changeJobBox;
        }// end function

        public function openChangeJobBox(param1:Boolean = true) : void
        {
            var _loc_2:* = 0;
            if (!this._changeJobBox)
            {
                this._changeJobBox = new ChangeJobBox();
                Global.popManager.addPop(this._changeJobBox);
            }
            if (param1)
            {
                _loc_2 = TaskModel.getInstance().curChangeJobTask();
                if (!_loc_2)
                {
                    return;
                }
            }
            if (!this._changeJobBox.isOpen)
            {
                ClickStream.add(ClickStreamId.OPEN_ZhuanZhi);
            }
            this._changeJobBox.open();
            return;
        }// end function

        public function openChangejobSurePanel() : void
        {
            if (!this._changeJobSurePanel)
            {
                this._changeJobSurePanel = new ChangeJobSurePanel();
                Global.popManager.addPop(this._changeJobSurePanel, false, false, true, true, false, true);
            }
            this._changeJobSurePanel.openOrClose();
            return;
        }// end function

        protected function getNewTask(event:TaskEvent) : void
        {
            var _loc_2:* = TaskMsgVO(event.data).taskId;
            if (_loc_2 == 62001 || _loc_2 == 62003 || _loc_2 == 62005)
            {
                ChangeJobControl.getInstance().openChangeJobBox(false);
            }
            return;
        }// end function

        private function updataBtn(event:TaskEvent) : void
        {
            var _loc_2:* = event.data as int;
            if (_loc_2 == 60002 || _loc_2 == 60003 || _loc_2 == 60004)
            {
                if (UserObj.getInstance().playerInfo.level < 220)
                {
                    MapControl.getInstance().removeFromTopIcon(TopActivateName.TOP_ICON_CHANGE_JOB);
                }
                this._hasChange1 = true;
            }
            else if (_loc_2 == 61002)
            {
                if (UserObj.getInstance().playerInfo.level < 290)
                {
                    MapControl.getInstance().removeFromTopIcon(TopActivateName.TOP_ICON_CHANGE_JOB);
                }
                this._hasChange2 = true;
            }
            else if (_loc_2 == 62005)
            {
                if (UserObj.getInstance().playerInfo.level < 350)
                {
                    MapControl.getInstance().removeFromTopIcon(TopActivateName.TOP_ICON_CHANGE_JOB);
                }
                this._hasChange3 = true;
            }
            else if (_loc_2 == 63001)
            {
                MapControl.getInstance().removeFromTopIcon(TopActivateName.TOP_ICON_CHANGE_JOB);
                if (this.changeJobBox)
                {
                    this.changeJobBox.playEffect();
                }
            }
            return;
        }// end function

        public function showOrHideMasterBtn(param1:Boolean) : void
        {
            if (param1)
            {
                MapControl.getInstance().addedToTopIcon(TopActivateName.TOP_ICON_CHANGE_JOB);
            }
            else
            {
                MapControl.getInstance().removeFromTopIcon(TopActivateName.TOP_ICON_CHANGE_JOB);
            }
            return;
        }// end function

        public function reqMasterChangeState() : void
        {
            this._protocol.reqMasterChangeState();
            return;
        }// end function

        public function resMasterChangeState(param1:ResGetActivatedStarInfo) : void
        {
            this._activeCount = param1.activeCount;
            this._prob = param1.prob;
            FrameworkGlobal.sendMsg(new Event("masterUpdate"));
            return;
        }// end function

        public function reqActivateStar() : void
        {
            this._protocol.reqActivateStar();
            this._isActiviteBack = false;
            return;
        }// end function

        public function resIsActivateSucceseHandler(param1:ResIsActivateSuccese) : void
        {
            this._isActiviteBack = true;
            var _loc_2:* = param1.isSuccese;
            if (_loc_2)
            {
                if (this.changeJobBox)
                {
                    this.changeJobBox.shock();
                    this.changeJobBox.playSuccessEffect();
                }
            }
            else if (this.changeJobBox)
            {
                this.changeJobBox.playFailEffect();
            }
            return;
        }// end function

        public function get hasChange1() : Boolean
        {
            return this._hasChange1;
        }// end function

        public function set hasChange1(param1:Boolean) : void
        {
            this._hasChange1 = param1;
            return;
        }// end function

        public function get hasChange2() : Boolean
        {
            return this._hasChange2;
        }// end function

        public function set hasChange2(param1:Boolean) : void
        {
            this._hasChange2 = param1;
            return;
        }// end function

        public function get hasChange3() : Boolean
        {
            return this._hasChange3;
        }// end function

        public function set hasChange3(param1:Boolean) : void
        {
            this._hasChange3 = param1;
            return;
        }// end function

        public function get activeCount() : int
        {
            return this._activeCount;
        }// end function

        public function set activeCount(param1:int) : void
        {
            this._activeCount = param1;
            return;
        }// end function

        public function get prob() : int
        {
            return this._prob;
        }// end function

        public function set prob(param1:int) : void
        {
            this._prob = param1;
            return;
        }// end function

        public function get isActiviteBack() : Boolean
        {
            return this._isActiviteBack;
        }// end function

        public function set isActiviteBack(param1:Boolean) : void
        {
            this._isActiviteBack = param1;
            return;
        }// end function

        public static function getInstance() : ChangeJobControl
        {
            if (_instance == null)
            {
                _instance = new ChangeJobControl;
            }
            return _instance;
        }// end function

    }
}
