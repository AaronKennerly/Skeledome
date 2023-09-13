using Godot;
using System;

public partial class Player : CharacterBody2D
{
	[Export]
	public PlayerControls controls = new PlayerControls();
	
	public const float Speed = 300.0f;
	public const float JumpVelocity = -600.0f;
	public const float Acceleration = 10.0f; 
	public const float Decceleration = 20.0f;
	public Vector2 Force;
	public float Mass = 60.0f;

	// Get the gravity from the project settings to be synced with RigidBody nodes.
	public float gravity = ProjectSettings.GetSetting("physics/2d/default_gravity").AsSingle();

	public override void _PhysicsProcess(double delta)
	{
		Vector2 velocity = Velocity;

		// Add the gravity.
		if (!IsOnFloor())
			if (velocity.Y < 0) velocity.Y += gravity * (float)delta;
			else velocity.Y += gravity * 2 * (float)delta; 

		// Handle Jump.
		if (Input.IsActionJustPressed(controls.jump) && IsOnFloor())
			velocity.Y = JumpVelocity;

		// Get the input direction and handle the movement/deceleration.
		// As good practice, you should replace UI actions with custom gameplay actions.
		
		// calculating Base Movement
		if(Input.IsActionPressed(controls.moveLeft)) {
				if (velocity.X > 0) velocity.X *= 0.75f; //If changing direction, happens slightly faster, feeling better
				velocity.X = Math.Max(velocity.X - Acceleration, -Speed);
		} else if(Input.IsActionPressed(controls.moveRight)) {
				if (velocity.X < 0) velocity.X *= 0.75f;
				velocity.X = Math.Min(velocity.X + Acceleration, Speed);
		} else {
			if (velocity.X < 0) velocity.X = Math.Min(velocity.X + Decceleration, 0);
			else velocity.X = Math.Max(velocity.X - Decceleration, 0);
		}

		Velocity = velocity;
		MoveAndSlide();
		UpdateForce(velocity);
	}
	
	public void UpdateForce(Vector2 velocity) {
		Force = velocity * Mass;
	}
}
