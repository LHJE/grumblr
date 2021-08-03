import React from 'react'

const ReviewForm = (props) => {
	return (
		<div className="wrapper">
			<form>
				<div>Have an experience with [Airline name]? Share your review!</div>
				<div className="field">
					<input type="text" name="title" placeholder="Review Title" />
				</div>
				<div className="field">
					<input type="text" name="title" placeholder="Review Description" />
				</div>
				<div className="field">
					<div className="rating-container">
						<div className="rating-title-text"> Rate This Airline </div>
							[Star rating goes here]
					</div>
				</div>
				<button type="submit"> Submit your review</button>
			</form>
		</div>
	)

}

export default ReviewForm
