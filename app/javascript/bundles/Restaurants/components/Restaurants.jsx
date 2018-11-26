import React, { Component } from 'react'
import axios from 'axios'
import Table from './Table'

class Restaurants extends Component {
  state = {
            restaurants: [],
            selectedRestaurant: [],
          }

  fetchRestaurants = () => {
    axios.get(`/restaurants.json`)
      .then((response) => {
        const restaurants = response.data
        this.setState({ restaurants: restaurants })     
      })
  }

  componentDidMount(){
    this.fetchRestaurants(this.state)
  }

  handleClick = (venue) => {
    let { selectedRestaurant } = this.state
    
    selectedRestaurant.push(venue)
    this.setState({ selectedRestaurant })
  }

  createPoll = () => {
    let { selectedRestaurant } = this.state
    selectedRestaurant = selectedRestaurant.map(rest => rest.id)
    axios.post('/polls.json', {poll: {restaurant_id: selectedRestaurant}})
      .then((response) => {
        Turbolinks.visit(`/polls/${response.data.id}/poll_responses`)
      })    
  }

  render(){
    const { restaurants, selectedRestaurant } = this.state
    return(
      <div className="select-venues animated fadeIn delay-1s">
        <p className="poll-instructions">Select the restaurants you want to create a poll with from the list below.</p>
        <div className="restaurant-list"> 
          <Table  restaurants={restaurants}
                  selectedRestaurant={selectedRestaurant}
                  handleClick={this.handleClick} 
          /> 
        </div>
        <button className="btn btn-outline-secondary waves-effect create-poll animated fadeIn delay-1s" onClick={this.createPoll}>Create Poll!</button>
      </div>
    )
  }
}

export default Restaurants