package com.game.artifact.view
{
    import com.f1.*;
    import com.f1.manager.resource.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.f1.vmc.*;
    import com.game.artifact.control.*;
    import com.manager.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import interfaces.*;

    public class ArtifactExtractStoveView extends Component implements IDragItem
    {
        private var acceptDragKeys:Array;
        private var bgLayer:Sprite;
        private var mvFire:VMCView;
        private var mvDragOver:MovieClip;

        public function ArtifactExtractStoveView(param1:Sprite)
        {
            this.acceptDragKeys = [ArtifactPackItemView.DRAG_KEY_EXTRACT];
            super(param1);
            this.bgLayer = param1;
            VResManager.load("res/artifactExtractStoveDragOver.swf", this.onLoadDragOverEffectComplete);
            this.mvFire = new VMCView();
            this.mvFire.auto = true;
            this.mvFire.loadRes("res/effect/artifact/fire.png", null, true);
            this.mvFire.updatePose("90", true);
            this.mvFire.move(80, 80);
            addChildAt(this.mvFire, 0);
            this.bgLayer.mouseEnabled = true;
            this.bgLayer.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            this.bgLayer.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            return;
        }// end function

        private function onRollOver(event:MouseEvent) : void
        {
            if (DragManager.getInstance().isInDrag())
            {
                DragManager.getInstance().onMouseIn(this);
            }
            return;
        }// end function

        private function onRollOut(event:MouseEvent) : void
        {
            if (DragManager.getInstance().isInDrag())
            {
                DragManager.getInstance().onMouseOut(this);
            }
            return;
        }// end function

        private function onLoadDragOverEffectComplete(param1) : void
        {
            this.mvDragOver = ToolKit.getNew("artifactExtractStoveDragOver");
            this.mvDragOver.visible = false;
            this.mvDragOver.x = -110;
            this.mvDragOver.y = -40;
            addChildAt(this.mvDragOver, 1);
            return;
        }// end function

        public function acceptKey() : Array
        {
            return this.acceptDragKeys;
        }// end function

        public function dragAccept(param1:IDragItem, param2:Object = null) : Boolean
        {
            return this.acceptKey().indexOf(param1.getKey()) != -1;
        }// end function

        public function completeDrag(param1:Object, param2:IDragItem = null, param3:IDragItem = null) : void
        {
            var _loc_4:* = new Point(FrameworkGlobal.stage.mouseX, FrameworkGlobal.stage.mouseY);
            ArtifactControl.getInstance().extractItem(param1 as PropInfo, _loc_4);
            return;
        }// end function

        public function dragEnter() : void
        {
            if (this.mvDragOver)
            {
                this.mvDragOver.visible = true;
                this.mvDragOver.play();
            }
            return;
        }// end function

        public function dragOut() : void
        {
            if (this.mvDragOver)
            {
                this.mvDragOver.visible = false;
                this.mvDragOver.stop();
            }
            return;
        }// end function

        public function getKey() : String
        {
            return null;
        }// end function

        public function dragSucc(param1:Boolean, param2:Point = null) : void
        {
            return;
        }// end function

    }
}
