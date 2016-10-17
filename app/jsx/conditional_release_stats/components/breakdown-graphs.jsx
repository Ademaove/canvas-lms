define([
  'react',
  'instructure-ui',
  './breakdown-graph-bar',
  '../helpers/score',
  'i18n!cyoe_assignment_sidebar',
], (React, { Spinner }, BarGraph, scoreHelpers, I18n) => {
  const { object, array, func, number, bool } = React.PropTypes

  class BreakdownGraphs extends React.Component {
    static get propTypes () {
      return {
        assignment: object.isRequired,
        ranges: array.isRequired,
        enrolled: number.isRequired,
        isLoading: bool.isRequired,

        // actions
        selectRange: func.isRequired,
      }
    }

    renderContent () {
      if (this.props.isLoading) {
        return (
          <div className='crs-breakdown-graph__loading'>
            <Spinner title={I18n.t('Loading')} size='small' />
            <p>{I18n.t('Loading Data..')}</p>
          </div>
        )
      } else {
        return this.renderBars()
      }
    }

    renderBars () {
      return this.props.ranges.map((bucket, i, ranges) => (
        <BarGraph
          key={i}
          rangeIndex={i}
          rangeStudents={bucket.size}
          totalStudents={this.props.enrolled}
          upperBound={scoreHelpers.transformScore(bucket.scoring_range.upper_bound, this.props.assignment, true)}
          lowerBound={scoreHelpers.transformScore(bucket.scoring_range.lower_bound, this.props.assignment, false)}
          selectRange={this.props.selectRange}
        />
      ))
    }

    render () {
      return (
        <div className='crs-breakdown-graph' >
          <h2>{I18n.t('Mastery Paths Breakdown')}</h2>
          {this.renderContent()}
        </div>
      )
    }
  }

  return BreakdownGraphs
})
