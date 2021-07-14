import React from "react";
import { Link } from "react-router-dom";

class Grumbls extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      grumbls: []
    };
  }

  componentDidMount() {
    const url = "/api/v1/grumbls/index";
    fetch(url)
      .then(response => {
        if (response.ok) {
          return response.json();
        }
        throw new Error("Network response was not ok.");
      })
      .then(response => this.setState({ grumbls: response }))
      .catch(() => this.props.history.push("/"));
  }
  render() {
    const { grumbls } = this.state;
    const allGrumbls = grumbls.map((grumbl, index) => (
      <div key={index} className="col-md-6 col-lg-4">
        <div className="card mb-4">
          <img
            src={grumbl.image}
            className="card-img-top"
            alt={`${grumbl.name} image`}
          />
          <div className="card-body">
            <h5 className="card-title">{grumbl.name}</h5>
            <Link to={`/grumbl/${grumbl.id}`} className="btn custom-button">
              View Grumbl
            </Link>
          </div>
        </div>
      </div>
    ));
    const noGrumbl = (
      <div className="vw-100 vh-50 d-flex align-items-center justify-content-center">
        <h4>
          No grumbls yet. Why not <Link to="/new_grumbl">create one</Link>
        </h4>
      </div>
    );

    return (
      <>
        <section className="jumbotron jumbotron-fluid text-center">
          <div className="container py-5">
            <h1 className="display-4">Grumbls for every occasion</h1>
            <p className="lead text-muted">
              We’ve pulled together our most popular grumbls, our latest
              additions, and our editor’s picks, so there’s sure to be something
              tempting for you to try.
            </p>
          </div>
        </section>
        <div className="py-5">
          <main className="container">
            <div className="text-right mb-3">
              <Link to="/grumbl" className="btn custom-button">
                Create New Grumbl
              </Link>
            </div>
            <div className="row">
              {grumbls.length > 0 ? allGrumbls : noGrumbl}
            </div>
            <Link to="/" className="btn btn-link">
              Home
            </Link>
          </main>
        </div>
      </>
    );
  }
}
export default Grumbls;
