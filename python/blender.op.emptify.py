import bpy

def main(context):
    obs = list(context.selected_objects)
    for ob in obs:
        empty = bpy.data.objects.new(ob.name+"_empty", None)
        scene = bpy.context.scene
        scene.objects.link(empty)
        bpy.ops.object.select_pattern(pattern=empty.name,extend=False)
        bpy.ops.object.select_pattern(pattern=ob.name,extend=True)
        bpy.ops.object.parent_no_inverse_set()
        bpy.ops.object.select_pattern(pattern=empty.name,extend=False)
        bpy.ops.object.parent_clear(type='CLEAR_KEEP_TRANSFORM')
        bpy.ops.object.select_pattern(pattern=ob.name,extend=False)
        bpy.ops.object.delete(use_global=False)
        
        scene.update()
        
class Emptyfy(bpy.types.Operator):
    """Tooltip"""
    bl_idname = "object.emptyfy"
    bl_label = "Emptify"

    @classmethod
    def poll(cls, context):
        return context.active_object is not None

    def execute(self, context):
        main(context)
        return {'FINISHED'}


def register():
    bpy.utils.register_class(Emptyfy)


def unregister():
    bpy.utils.unregister_class(Emptyfy)


if __name__ == "__main__":
    register()

    # test call
    #bpy.ops.object.emptyfy()
